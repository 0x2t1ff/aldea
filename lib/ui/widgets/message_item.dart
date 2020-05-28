import 'package:aldea/models/message_model.dart';
import "package:flutter/material.dart";
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;

class MessageItem extends StatelessWidget {
  final MessageModel model;
  final String currentUser;

  const MessageItem({Key key, this.currentUser, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int comparation = currentUser.compareTo(model.senderId);
    return comparation == 0
        ? Padding(
            padding:
                EdgeInsets.only(left: devicesize.screenWidth(context) * 0.32, top: devicesize.screenHeight(context) * 0.01),
            child: Container(
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
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
                                    horizontal:
                                        devicesize.screenWidth(context) * 0.037),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical:
                                            devicesize.screenHeight(context) *
                                                0.007,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: devicesize
                                                    .screenHeight(context) *
                                                0.002, ),
                                        child: Container(
                                          width:
                                              devicesize.screenWidth(context) *
                                                  0.562,
                                          child: model.isImage ? Image(image: NetworkImage(model.message)) : Text(
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
                                top: devicesize.screenHeight(context) * 0.003,
                              ),
                              child: Text(
                                model.time.substring(0 , 19),
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
        : Container(
            width: devicesize.screenWidth(context) * 0.9,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: devicesize.screenHeight(context) * 0.025,
                      right: devicesize.screenWidth(context) * 0.02,
                    ),
                    child: CircleAvatar(backgroundImage: NetworkImage(model.imageUrl),),
                  ),
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                color: custcolor.blueTheme),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      devicesize.screenWidth(context) * 0.06),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          devicesize.screenHeight(context) *
                                              0.007,
                                    ),
                                    child: Text(
                                     model.username,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Raleway',
                                          fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 12),
                                    child: Container(
                                      width: devicesize.screenWidth(context) *
                                          0.662,
                                      child: model.isImage ? Image(image: NetworkImage(model.message)) : Text(
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
                                bottom: devicesize.screenHeight(context) * 0.005 ,
                                right: devicesize.screenWidth(context) * 0.538),
                            child: Text(
                              model.time.substring(0, 19),
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
          );
  }
}
