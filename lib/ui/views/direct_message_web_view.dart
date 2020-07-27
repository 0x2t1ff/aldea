import 'package:aldea/models/chat_room_model.dart';
import 'package:aldea/ui/widgets/chatroom_item.dart';
import 'package:aldea/viewmodels/direct_message_web_viewmodel.dart';
import 'package:firebase/firebase.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class DirectMessageWebView extends StatefulWidget {
  @override
  _DirectMessageWebViewState createState() => _DirectMessageWebViewState();
}

class _DirectMessageWebViewState extends State<DirectMessageWebView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DirectMessageWebViewModel>.reactive(
      viewModelBuilder: () => DirectMessageWebViewModel(),
      onModelReady: (model) => model.getStream(),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: custcolor.almostBlack,
        body: model.stream != null
            ? ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: model.stream.length,
                itemBuilder: (context, index) {
                  return StreamBuilder<QueryEvent>(
                    stream: model.stream[index].asBroadcastStream(),
                    builder: (ctx, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'No Data...',
                        );
                      } else if (snapshot.hasError) {
                        return Text("error");
                      } else {
                        var chatModel;
                        chatModel = ChatRoomModel.fromMap(
                            snapshot.data.snapshot.val()["lastMessage"]);
                        print(chatModel);
                        return ChatRoomItem(
                            currentUser: model.currentUser.uid,
                            urls: snapshot.data.snapshot.val()["avatarUrl"],
                            users: snapshot.data.snapshot.val()["users"],
                            username: snapshot.data.snapshot.val()["username"],
                            index: index,
                            model: chatModel,
                            openChat: () {

                              model.openChat(model.chatRooms[index]);
                            });
                      }
                    },
                  );
                })
            : Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                ),
              ),
      ),
    );
  }
}
