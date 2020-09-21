import 'dart:ui';

import 'package:aldea/models/user_post_model.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/like_button.dart';
import 'package:aldea/ui/widgets/posts_carousel.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import 'adaptive_text.dart';

class UserPostItem extends StatefulWidget {
  final UserPostModel postModel;
  final Function likeFunction;
  final Function goToComments;
  final Function navigate;
  final bool isLiked;
  final String uid;
  final bool isMod;
  final Function deletePost;
  const UserPostItem(
      {Key key,
      this.postModel,
      this.goToComments,
      this.likeFunction,
      this.isLiked,
      this.navigate,
      this.uid,
      this.isMod,
      this.deletePost})
      : super(key: key);

  @override
  _UserPostItemState createState() => _UserPostItemState();
}

class _UserPostItemState extends State<UserPostItem> {
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('dd/M  hh:mm ');
    var formatToday = DateFormat("hh:mm");
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inHours > 0 && diff.inDays == 0) {
      time = " Today " + formatToday.format(date);
    } else if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 1) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  bool showingDelete = false;
  @override
  Widget build(BuildContext context) {
    bool liked = widget.isLiked;

    String dayTime = readTimestamp(widget.postModel.date.seconds);
    Color greyColor = Color(0xff3a464d);
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: custcolor.blueishGreyColor,
          boxShadow: [
            BoxShadow(
              color: Color(0xff0f1013),
              blurRadius: 5.0,
              spreadRadius: 5.0,
              offset: Offset(
                5.0,
                5.0,
              ),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: devicesize.screenWidth(context),
              height: devicesize.screenHeight(context) * 0.12,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        left: devicesize.screenWidth(context) * 0.06),
                    child: GestureDetector(
                      onTap: widget.navigate,
                      child: CircleAvatar(
                        radius: devicesize.screenWidth(context) * 0.06,
                        backgroundImage:
                            NetworkImage(widget.postModel.avatarUrl),
                      ),
                    ),
                  ),
                  Container(
                    width: devicesize.screenWidth(context) * 0.65,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: devicesize.screenWidth(context) * 0.09),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 4),
                            child: Text(widget.postModel.name,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Raleway',
                                    fontSize:
                                        devicesize.screenWidth(context) * 0.046,
                                    color: custcolor.almostWhite)),
                          ),
                          Text(
                            //TODO: formatear el datetime para que aparezca como toca
                            dayTime,
                            style: TextStyle(
                                color: Color(0xff3a464d),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Raleway',
                                fontSize:
                                    devicesize.screenWidth(context) * 0.03),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    iconSize: devicesize.screenWidth(context) * 0.08,
                    icon: Icon(Icons.share),
                    onPressed: () => print("pressed"),
                    color: custcolor.blueTheme,
                  ),
                ],
              ),
            ),
            Container(
              width: devicesize.screenWidth(context),
              height: widget.postModel.imageUrl.isEmpty == true
                  ? 0
                  : devicesize.screenHeight(context) * 0.4,
              child: widget.postModel.imageUrl.isEmpty == true
                  ? Container()
                  : PostCarousel(imageUrl: widget.postModel.imageUrl),
            ),
            Padding(
              padding: widget.postModel.imageUrl.isEmpty
                  ? EdgeInsets.only(
                      left: devicesize.screenWidth(context) * 0.04,
                    )
                  : EdgeInsets.only(
                      left: devicesize.screenWidth(context) * 0.04,
                      top: devicesize.screenHeight(context) * 0.01,
                    ),
              child: widget.postModel.imageUrl.isEmpty
                  ? AdaptiveText(
                      widget.postModel.description,
                      600,
                      TextStyle(
                          fontFamily: "Raleway",
                          color: custcolor.almostWhite,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                    )
                  : AdaptiveText(
                      widget.postModel.description,
                      95,
                      TextStyle(
                          fontFamily: "Raleway",
                          color: custcolor.almostWhite,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                    ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: devicesize.screenHeight(context) * 0.02),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: devicesize.screenWidth(context) * 0.06,
                            right: devicesize.screenWidth(context) * 0.138,
                          ),
                          child: Column(
                            children: <Widget>[
                              LikeButton(
                                likeFunction: widget.likeFunction,
                                liked: liked,
                                likes: widget.postModel.likes,
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.goToComments,
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.comment,
                                color: custcolor.blueTheme,
                                size: devicesize.screenWidth(context) * 0.07,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: devicesize.screenHeight(context) *
                                        0.005),
                                child: Text(
                                    widget.postModel.commentCount == null
                                        ? "0"
                                        : widget.postModel.commentCount
                                            .toString(),
                                    style: TextStyle(
                                        color: greyColor,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14)),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: devicesize.screenWidth(context) * 0.48,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: devicesize.screenWidth(context) * 0.07,
                            ),
                            onPressed: () {
                              print("more vert pressed");
                              print(showingDelete);
                              setState(() {
                                showingDelete = !showingDelete;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      showingDelete
          ? Positioned(
              left: screenWidth(context) * 0.25,
              top: widget.postModel.imageUrl.isEmpty == true
                  ? screenHeight(context) * 0.12
                  : screenHeight(context) * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 6.0,
                    sigmaY: 6.0,
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        color: custcolor.blueTheme.withOpacity(0.4),
                      ),
                      width: screenWidth(context) * 0.5,
                      height: screenHeight(context) * 0.22,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context) * 0.04,
                                right: screenWidth(context) * 0.04,
                                top: screenHeight(context) * 0.03),
                            child: Text(
                              "¿Estas seguro que quieres borrar la publicación?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: custcolor.almostWhite,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context) * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  //TODO: testing if this works
                                  onTap: () {
                                    widget.deletePost();
                                    setState(() {
                                      showingDelete = false;
                                    });
                                  },
                                  child: Container(
                                      width: screenHeight(context) * 0.06,
                                      height: screenHeight(context) * 0.06,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(200)),
                                      child: Center(
                                          child: Icon(Icons.check,
                                              color: custcolor.almostWhite,
                                              size: 35))),
                                ),
                                GestureDetector(
                                  onTap: () => setState(() {
                                    showingDelete = false;
                                  }),
                                  child: Container(
                                      width: screenHeight(context) * 0.06,
                                      height: screenHeight(context) * 0.06,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(200))),
                                      child: Center(
                                          child: Icon(Icons.close,
                                              color: custcolor.almostWhite,
                                              size: 40))),
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ))
          : Container()
    ]);
  }
}
