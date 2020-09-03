import 'package:aldea/models/message_model.dart';
import 'package:aldea/ui/widgets/community_message_item.dart';
import 'package:aldea/ui/widgets/message_item.dart';
import 'package:aldea/viewmodels/community_chat_view_model.dart';
import '../shared/ui_helpers.dart' as devicesize;
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class CommunityChatView extends StatelessWidget {
  final String communityId;

  final bool petitionsShowing;

  const CommunityChatView({Key key, this.communityId, this.petitionsShowing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("builded");
    final messageController = TextEditingController();
    ScrollController controller = new ScrollController();
    return ViewModelBuilder<CommunityChatViewModel>.reactive(
      viewModelBuilder: () => CommunityChatViewModel(),
      onModelReady: (model) async {
        await model.getMessages(communityId);
        controller.addListener(() {
          if (controller.position.pixels /
                      controller.position.maxScrollExtent >=
                  0.8 &&
              model.isLoadingMore == false) {
            
            model.loadMoreMessages(communityId);
          }
        });
        
      },
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
                child: model.messages != null
                    ? ListView.builder(
                        reverse: true,
                        controller: controller,
                        itemCount: model.messages.length,
                        itemBuilder: (ctx, index) {
                          return MessageItem(
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
                          print(" button pressed");

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
