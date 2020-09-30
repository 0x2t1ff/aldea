import 'package:aldea/constants/languages.dart';
import 'package:aldea/models/chat_room_model.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/chatroom_item.dart';
import 'package:aldea/viewmodels/direct_message_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class DirectMessageView extends StatefulWidget {
  @override
  _DirectMessageViewState createState() => _DirectMessageViewState();
}

class _DirectMessageViewState extends State<DirectMessageView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DirectMessageViewModel>.reactive(
      viewModelBuilder: () => DirectMessageViewModel(),
      onModelReady: (model) => model.getChatsStream(),
      builder: (context, model, child) => WillPopScope(
        onWillPop: model.onWillPop,
        child: Scaffold(
          body: Container(
            height: screenHeight(context),
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment(0.0, 0.0),
                  stops: [0.0, 0.25, 0.25, 0.5, 0.5, 0.75, 0.75, 1],
                  colors: [
                    custcolor.darkGrey,
                    custcolor.darkGrey,
                    custcolor.blueishGreyColor,
                    custcolor.blueishGreyColor,
                    custcolor.darkGrey,
                    custcolor.darkGrey,
                    custcolor.blueishGreyColor,
                    custcolor.blueishGreyColor,
                  ],
                  tileMode: TileMode.repeated),
            ),
            child: StreamBuilder<QuerySnapshot>(
                stream: model.chatsStream,
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error"),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data.documents.isEmpty) {
                    return Center(
                      child: Align(
                        child: Container(
                            width: screenWidth(context) * 0.65,
                            height: screenWidth(context) * 0.6,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: custcolor.darkGrey.withOpacity(1),
                                    spreadRadius: 2,
                                    blurRadius: 1,
                                    offset: Offset(
                                        3, 3), // changes position of shadow
                                  ),
                                ],
                                color: custcolor.blueTheme,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: screenWidth(context) * 0.1,
                                  top: screenHeight(context) * 0.035,
                                  left: screenWidth(context) * 0.1),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    languages[model.currentLanguage]["oops"],
                                    style: TextStyle(
                                        color: custcolor.almostWhite,
                                        fontFamily: "Raleway",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: screenHeight(context) * 0.02,
                                    ),
                                    child: Container(
                                      color: custcolor.almostWhite,
                                      width: double.infinity,
                                      height: 3,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight(context) * 0.02,
                                        bottom: screenHeight(context) * 0.02),
                                    child: Text(
                                        languages[model.currentLanguage]
                                            ["chats empty"],
                                        style: TextStyle(
                                          color: custcolor.almostBlack,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        )),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                  } else {
                    model.setChatRooms(snapshot.data.documents);
                    return SmartRefresher(
                        enablePullUp: true,
                        enablePullDown: false,
                        controller: model.refreshController,
                        onLoading: () {
                          model.getChatsStream();
                          model.refreshController.loadComplete();
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: model.chatRooms.length,
                          itemBuilder: (ctx, i) => ChatRoomItem(
                              currentUser: model.currentUser.uid,
                              urls: model.chatRooms[i].avatarUrls,
                              users: model.chatRooms[i].users,
                              username: model.chatRooms[i].usernames,
                              index: i,
                              model: model.chatRooms[i],
                              openChat: () {
                                model.openChat(
                                    snapshot.data.documents.reversed.toList()[i].documentID);
                              }),
                        ));
                  }
                }),
          ),
        ),
      ),
    );
  }
}
