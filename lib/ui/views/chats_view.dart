import 'package:aldea/models/message_model.dart';
import 'package:aldea/ui/widgets/message_item.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/chats_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../shared/ui_helpers.dart' as devicesize;
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import 'package:flutter/cupertino.dart';
import "../shared/app_colors.dart" as custcolor;

class ChatsView extends StatelessWidget {
  final String chatroomId;

  const ChatsView({Key key, this.chatroomId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("rebuilded");

    final messageController = TextEditingController();
    return ViewModelBuilder<ChatsViewModel>.reactive(
      viewModelBuilder: () => ChatsViewModel(),
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
                    ? StreamBuilder<QuerySnapshot>(
                        stream: model.getChatStream(chatroomId),
                        builder: (ctx, querySnapshot) {
                          if (querySnapshot.data != null &&
                              querySnapshot.data.documents.isNotEmpty) {
                            model.addMessages(querySnapshot.data.documents);

                            return SmartRefresher(
                              header: CustomHeader(
                                height: model.refreshController.isRefresh ? 0 : 20,
                                builder: (context, mode) {
                                  Widget body;
                                  if (mode == RefreshStatus.idle) {
                                    body = Text("pull down refresh");
                                  } else if (mode == RefreshStatus.refreshing) {
                                    body = CupertinoActivityIndicator();
                                  } else if (mode == RefreshStatus.canRefresh) {
                                    body = Text("release to refresh");
                                  } else if (mode == RefreshStatus.completed) {
                                    body = Text("refreshCompleted!");
                                  }
                                  return Container(
                                    height: 0.0,
                                    child: Center(
                                      child: body,
                                    ),
                                  );
                                },
                              ),
                              onRefresh: () async {
                                await model.addRequestOldMessages(chatroomId);
                                model.refreshController.refreshCompleted();
                              },
                              controller: model.refreshController,
                              child: ListView.builder(
                                  controller: model.scrollController,
                                  itemCount: model.messages.length,
                                  itemBuilder: (context, index) {
                                    if (model.isFirstLoad) model.scrollDown();
                                    return MessageItem(
                                      heroAnimation: () {
                                        List url = [];
                                        url.add(model.messages[index].message);
                                        model.openHeroView(url);
                                      },
                                      model: model.messages[index],
                                      currentUser: model.currentUser.uid,
                                    );
                                  }),
                            );
                          }
                          return Container();
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
