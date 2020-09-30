import 'package:aldea/models/message_model.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;

class MessageItem extends StatelessWidget {
  final MessageModel model;
  final String currentUser;
  final Function navigateToUser;
  final Function heroAnimation;

  const MessageItem(
      {Key key,
      this.currentUser,
      this.model,
      this.heroAnimation,
      this.navigateToUser})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    int comparation = currentUser.compareTo(model.senderId);
    return comparation == 0
        ? Padding(
            padding: EdgeInsets.only(
                left: devicesize.screenWidth(context) * 0.38,
                top: devicesize.screenHeight(context) * 0.02),
            child: Container(
              width: devicesize.screenWidth(context) * 0.662,
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <
                  Widget>[
                Container(
                  width: devicesize.screenWidth(context) * 0.562,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)),
                              color: custcolor.blueTheme),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: model.isImage
                                    ? 0
                                    : devicesize.screenWidth(context) * 0.037),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: model.isImage
                                        ? devicesize.screenHeight(context) *
                                            0.00
                                        : devicesize.screenHeight(context) *
                                            0.007,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: model.isImage
                                          ? 0
                                          : devicesize.screenHeight(context) *
                                              0.007,
                                    ),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth:
                                              devicesize.screenWidth(context) *
                                                  0.562),
                                      child: model.isImage
                                          ? Container(
                                              child: model.isImage
                                                  ? GestureDetector(
                                                      onTap: heroAnimation,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          child: Container(
                                                            width: devicesize
                                                                    .screenWidth(
                                                                        context) *
                                                                0.7,
                                                            height: devicesize
                                                                    .screenWidth(
                                                                        context) *
                                                                0.7,
                                                            child: Image(
                                                              image: NetworkImage(
                                                                  model
                                                                      .message),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )),
                                                    )
                                                  : Text(
                                                      model.message,
                                                      style: TextStyle(
                                                        color: custcolor
                                                            .almostWhite,
                                                        fontFamily: 'Raleway',
                                                      ),
                                                    ),
                                            )
                                          : Text(
                                              model.message,
                                              style: TextStyle(
                                                color: custcolor.almostWhite,
                                                fontFamily: 'Raleway',
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: devicesize.screenHeight(context) * 0.005,
                          ),
                          child: Text(
                            DateFormat("dd/M/yy hh:mm")
                                .format(model.createdAt.toDate())
                                .toString(), //.substring(10, 16),
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Raleway',
                              fontSize: 11,
                            ),
                          ),
                        )
                      ]),
                ),
              ]),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
                top: devicesize.screenHeight(context) * 0.02,
                left: devicesize.screenWidth(context) * 0.02),
            child: Container(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <
                  Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      bottom: devicesize.screenHeight(context) * 0.025,
                      right: devicesize.screenWidth(context) * 0.02,
                      left: devicesize.screenWidth(context) * 0.02),
                  child: GestureDetector(
                    onTap: navigateToUser,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(model.imageUrl),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                              color: custcolor.blueTheme),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: model.isImage
                                  ? 0
                                  : devicesize.screenWidth(context) * 0.04,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: model.isImage
                                        ? devicesize.screenHeight(context) * 0.0
                                        : devicesize.screenHeight(context) *
                                            0.007,
                                  ),
                                  child: model.isImage
                                      ? Container()
                                      : Text(
                                          model.username,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Raleway',
                                              fontSize: 12),
                                        ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: model.isImage
                                          ? 0
                                          : devicesize.screenHeight(context) *
                                              0.015),
                                  child: Container(
                                    child: model.isImage
                                        ? GestureDetector(
                                            onTap: heroAnimation,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10),
                                                    bottomRight:
                                                        Radius.circular(10)),
                                                child: Container(
                                                  width: devicesize.screenWidth(
                                                          context) *
                                                      0.7,
                                                  height:
                                                      devicesize.screenWidth(
                                                              context) *
                                                          0.7,
                                                  child: Image(
                                                    image: NetworkImage(
                                                        model.message),
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          )
                                        : Text(
                                            model.message,
                                            style: TextStyle(
                                              color: custcolor.almostWhite,
                                              fontFamily: 'Raleway',
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: devicesize.screenHeight(context) * 0.005,
                              bottom: devicesize.screenHeight(context) * 0.005,
                              right: devicesize.screenWidth(context) * 0.538),
                          child: Text(
                            DateFormat("dd/M/yy hh:mm")
                                .format(model.createdAt.toDate())
                                .toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontFamily: 'Raleway',
                              fontSize: 11,
                            ),
                          ),
                        )
                      ]),
                ),
              ]),
            ),
          );
  }
}
