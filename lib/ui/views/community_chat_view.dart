import 'package:aldea/models/message_model.dart';
import 'package:aldea/ui/widgets/message_item.dart';
import 'package:aldea/viewmodels/community_chat_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../shared/ui_helpers.dart' as devicesize;
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;
import 'package:flutter/cupertino.dart';

class CommunityChatView extends StatelessWidget {
  final String communityId;

  final bool petitionsShowing;

  const CommunityChatView({Key key, this.communityId, this.petitionsShowing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    return ViewModelBuilder<CommunityChatViewModel>.reactive(
      viewModelBuilder: () => CommunityChatViewModel(),
      createNewModelOnInsert: false,
      builder: (context, model, child) => Scaffold(
        backgroundColor: custcolor.darkBlue,
        body: Container(
          color: custcolor.almostBlack,
          child: Column(
            children: <Widget>[
              Container(
                  height: petitionsShowing
                      ? devicesize.screenHeight(context) * 0.65 -
                          MediaQuery.of(context).viewInsets.bottom
                      :
                      //TODO: testear que esta altura funciona , calculo pocho dice q es esto _but_ who knows
                      devicesize.screenHeight(context) * 0.71 -
                          MediaQuery.of(context).viewInsets.bottom,
                  color: custcolor.darkBlue,
                  width: devicesize.screenWidth(context),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: model.getChatStream(communityId),
                    builder: (ctx, querySnapshot) {
                      if (querySnapshot.hasData &&
                          querySnapshot.data.documents.isNotEmpty) {
                        model.addMessages(querySnapshot.data.documents);

                        return SmartRefresher(
                          header: CustomHeader(
                            height: model.refreshController.isRefresh ? 0 : 30,
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
                            await model.addRequestOldMessages(communityId);
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
                                  navigateToUser: () => model
                                      .navigate(model.messages[index].senderId),
                                );
                              }),
                        );
                      }
                      return Container();
                    },
                  )),
              Container(
                constraints: BoxConstraints(
                  maxWidth: devicesize.screenWidth(context),
                ),
                height: devicesize.screenHeight(context) * 0.12,
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
                          await model.selectMessageImage().then((value) => model
                              .uploadImage(
                                  image: value, communityId: communityId)
                              .then((value) => model.sendCommunityMessage(
                                  value,
                                  model.currentUser.uid,
                                  communityId,
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
                              ? model.sendCommunityMessage(
                                  messageController.text,
                                  model.currentUser.uid,
                                  communityId,
                                  model.currentUser.name,
                                  model.currentUser.picUrl,
                                  false)
                              : print("");
                          messageController.clear();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
