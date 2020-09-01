import 'package:aldea/models/chat_room_model.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/chatroom_item.dart';
import 'package:aldea/viewmodels/direct_message_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
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
      disposeViewModel: true,
      onModelReady: (model) {
        model.getStream();
        print(model.initialData);
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: model.onWillPop,
        child: Scaffold(
          backgroundColor: custcolor.almostBlack,
          body: model.stream != null
              ? ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: model.stream.length < 8 ? 8 : model.stream.length,
                  itemBuilder: (context, index) {
                    if (model.stream.length > index) {
                      return StreamBuilder<Event>(
                          stream: model.stream[index].asBroadcastStream(),
                          builder: (ctx, snapshot) {
                            
                            print(snapshot.hasData);
                            print("the print of the snpashot");
                            if (!snapshot.hasData) {
                              return Text(
                                'No Data...',
                              );
                            } else if (snapshot.hasError) {
                              return Text("error");
                            } else {
                              var chatModel;
                              chatModel = ChatRoomModel.fromMap(
                                  snapshot.data.snapshot.value["lastMessage"]);

                              return ChatRoomItem(
                                  unreadMessages: snapshot
                                      .data.snapshot.value["unreadMessages"],
                                  currentUser: model.currentUser.uid,
                                  urls:
                                      snapshot.data.snapshot.value["avatarUrl"],
                                  users: snapshot.data.snapshot.value["users"],
                                  username:
                                      snapshot.data.snapshot.value["username"],
                                  index: index,
                                  model: chatModel,
                                  openChat: () {
                                    print(snapshot.data.snapshot.value
                                        .toString());
                                    model.openChat(model.chatRooms[index]);
                                  });
                            }
                          });
                    } else {
                      return Container(
                        width: double.infinity,
                        height: screenHeight(context) * 0.103,
                        color: index % 2 == 0
                            ? custcolor.darkGrey
                            : custcolor.backgroundColor,
                      );
                    }
                  })
              : Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                  ),
                ),
        ),
      ),
    );
  }
}
