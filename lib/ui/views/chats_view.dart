import 'package:aldea/models/message_model.dart';
import 'package:aldea/ui/widgets/message_item.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/chats_view_model.dart';
import '../shared/ui_helpers.dart' as devicesize;
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class ChatsView extends StatelessWidget {
  final String chatroomId;

  const ChatsView({Key key, this.chatroomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuilded");
    ScrollController controller = new ScrollController();
    bool flag = false;

    final messageController = TextEditingController();
    return ViewModelBuilder<ChatsViewModel>.reactive(
      viewModelBuilder: () => ChatsViewModel(),
      onModelReady: (model) async {
        await model.getMessages(chatroomId);
        controller.addListener(() {
          if (controller.position.pixels /
                      controller.position.maxScrollExtent >=
                  0.8 &&
              model.isLoadingMore == false) {
            model.loadMoreMessages(chatroomId);
          }
        });
      },
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: custcolor.darkBlue,
        resizeToAvoidBottomPadding: true,
        body: Container(
          child: Column(
            children: <Widget>[
              NotchFiller(),
              Container(
                height: devicesize.screenHeight(context) * 0.9 -
                    MediaQuery.of(context).viewInsets.bottom,
                color: custcolor.darkBlue,
                width: devicesize.screenWidth(context),
                child: model.messages != null
                    ? ListView.builder(
                        reverse: true,
                        controller: controller,
                        itemCount: model.messages.length,
                        itemBuilder: (ctx, index) {
                          model.readMessage(chatroomId);
                          return MessageItem(
                            navigateToUser: () => model.navigateToUser(model.messages.reversed.elementAt(index)["senderId"]),
                            heroAnimation: () {
                              List url = [];
                              url.add(model.messages[index]["message"]);
                              model.openHeroView(url);
                            },
                            model: MessageModel.fromMap(
                                model.messages.reversed.elementAt(index)),
                            currentUser: model.currentUser.uid,
                          );
                        },
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              custcolor.blueishGreyColor),
                        ),
                      ),
              ),
              Container(
                  constraints: BoxConstraints(
                    maxWidth: devicesize.screenWidth(context),
                  ),
                  height: devicesize.screenHeight(context) * 0.1,
                  color: custcolor.almostBlack,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: devicesize.screenHeight(context) * 0.01),
                        child: Container(
                          width: devicesize.screenWidth(context) * 0.58,
                          padding: EdgeInsets.only(
                              left: devicesize.screenWidth(context) * 0.02,
                              top: devicesize.screenHeight(context) * 0.002,
                              bottom: devicesize.screenHeight(context) * 0.004),
                          decoration: BoxDecoration(
                            color: custcolor.blueTheme,
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: TextFormField(
                            enableSuggestions: true,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: messageController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      devicesize.screenWidth(context) * 0.035),
                              hintText: "   Envia un mensaje...",
                              hintStyle: TextStyle(
                                  color: Color(0xff3a464d),
                                  fontFamily: "Raleway",
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                color: custcolor.almostWhite,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: devicesize.screenWidth(context) * 0.01,
                            bottom: devicesize.screenWidth(context) * 0.01),
                        child: IconButton(
                          icon: Icon(
                            Icons.image,
                            color: custcolor.blueTheme,
                            size: devicesize.screenWidth(context) * 0.08,
                          ),
                          onPressed: () async {
                            print(" button pressed");

                            await model.selectMessageImage().then((value) =>
                                model
                                    .uploadImage(
                                        image: value, chatId: chatroomId)
                                    .then((value) => model.sendMessage(
                                        value,
                                        model.currentUser.uid,
                                        chatroomId,
                                        model.currentUser.name,
                                        model.currentUser.picUrl,
                                        true)));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            
                            bottom: devicesize.screenWidth(context) * 0.01),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera,
                            color: custcolor.blueTheme,
                            size: devicesize.screenWidth(context) * 0.08,
                          ),
                          onPressed: () async {
                            print(" button pressed");

                            await model.selectCameraImage().then((value) =>
                                model
                                    .uploadImage(
                                        image: value, chatId: chatroomId)
                                    .then((value) => model.sendMessage(
                                        value,
                                        model.currentUser.uid,
                                        chatroomId,
                                        model.currentUser.name,
                                        model.currentUser.picUrl,
                                        true)));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: devicesize.screenWidth(context) * 0.01,
                           ),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            size: devicesize.screenWidth(context) * 0.07,
                            color: custcolor.blueTheme,
                          ),
                          onPressed: () {
                            messageController.text != ""
                                ? model.sendMessage(
                                    messageController.text,
                                    model.currentUser.uid,
                                    this.chatroomId,
                                    model.currentUser.name,
                                    model.currentUser.picUrl,
                                    false)
                                : print("");
                            messageController.clear();
                          },
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
