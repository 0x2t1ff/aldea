import 'dart:async';
import 'package:aldea/models/message_model.dart';
import 'package:aldea/ui/widgets/message_item.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/chats_view_model.dart';
import '../shared/ui_helpers.dart' as devicesize;
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class ChatsView extends StatelessWidget {
  final String chatroomId;

  const ChatsView({Key key, this.chatroomId}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    print("rebuilded");
    ScrollController _controller = new ScrollController();
    bool flag = false;

    final messageController = TextEditingController();
    return ViewModelBuilder<ChatsViewModel>.reactive(
      viewModelBuilder: () => ChatsViewModel(),
      onModelReady: (model) => model.getMessages(chatroomId),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: custcolor.darkBlue,
        resizeToAvoidBottomPadding: true,
        body: Container(
          child: Column(
            children: <Widget>[
              NotchFiller(),
              Container(
                height: devicesize.screenHeight(context) * 0.8487 -
                    MediaQuery.of(context).viewInsets.bottom,
                color: custcolor.darkBlue,
                width: devicesize.screenWidth(context),
                child: model.messages != null
                    ? StreamBuilder<Event>(
                        stream: model.messages,
                        builder: (ctx, snapshot) {
                          if (!snapshot.hasData) {
                            return Text(
                              'No Data...',
                            );
                          } else if (snapshot.hasError) {
                            return Text("error");
                          } else if (snapshot.data.snapshot.value == null) {
                            return Center(
                                child: Text(" send your first message!"));
                          } else {
                            Map<dynamic, dynamic> messageMaps =
                                snapshot.data.snapshot.value;

                            List messageList = messageMaps.values.toList();

                            messageList.sort((a, b) {
                              var r = a["time"]
                                  .toString()
                                  .compareTo(b["time"].toString());

                              return r;
                            });

                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      devicesize.screenHeight(context) * 0.01),
                              child: ListView.builder(
                                  controller: _controller,
                                  itemCount: messageList.length,
                                  itemBuilder: (context, index) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                          if(flag == false){
                                      _controller.animateTo(
                                          _controller.position.maxScrollExtent,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeOut);
                                          flag = true;}
                                    });
                                    return MessageItem(
                                      model: MessageModel.fromMap(
                                          messageList[index]),
                                      currentUser: model.currentUser.uid,
                                    );
                                  }),
                            );
                          }
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
                  height: devicesize.screenHeight(context) * 0.09,
                  color: custcolor.almostBlack,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: devicesize.screenHeight(context) * 0.01),
                        child: Container(
                          width: devicesize.screenWidth(context) * 0.58,
                          padding: EdgeInsets.only(
                              left: devicesize.screenWidth(context) * 0.02),
                          decoration: BoxDecoration(
                            color: custcolor.blueTheme,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            enableSuggestions: true,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: messageController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      devicesize.screenWidth(context) * 0.025),
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
                            left: devicesize.screenWidth(context) * 0.04,
                            bottom: devicesize.screenWidth(context) * 0.02),
                        child: IconButton(
                          icon: Icon(
                            Icons.image,
                            color: custcolor.blueTheme,
                            size: devicesize.screenWidth(context) * 0.1,
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
                            bottom: devicesize.screenWidth(context) * 0.01,
                            left: devicesize.screenWidth(context) * 0.04),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            size: devicesize.screenWidth(context) * 0.09,
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
