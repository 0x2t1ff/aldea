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
  final double height;
  final bool petitionsShowing;

  const CommunityChatView(
      {Key key, this.communityId, this.height, this.petitionsShowing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    ScrollController _controller = new ScrollController();
    return ViewModelBuilder<CommunityChatViewModel>.reactive(
      viewModelBuilder: () => CommunityChatViewModel(),
      onModelReady: (model) => model.getMessages(communityId),
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: custcolor.almostBlack,
          child: Column(
            children: <Widget>[
              Container(
                height: petitionsShowing
                    ? devicesize.screenHeight(context) * 0.34314 +
                        height * 0.988 -
                        MediaQuery.of(context).viewInsets.bottom
                    : devicesize.screenHeight(context) * 0.395 +
                        height * 0.988 -
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

                            // hace que cuando envias mensaje baje
                            //TODO intentar hacer un singlechildscrollview y en vez de usar el listView.builder usar un .forEach() donde devuelva los mensajes , al singlechildscrollview meterle un ScrollController y que con cada resize/mensaje haga scroll hacia abajo
                            return ListView.builder(
                                reverse: false,
                                controller: _controller,
                                itemCount: messageList.length,
                                itemBuilder: (context, index) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((timeStamp) {
                                    _controller.animateTo(
                                        _controller.position.maxScrollExtent,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.easeOut);
                                  });
                                  return CommunityMessageItem(
                                    model: MessageModel.fromMap(
                                        messageList[index]),
                                    currentUser: model.currentUser.uid,
                                  );
                                });
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
