import 'dart:ui';

import 'package:aldea/constants/languages.dart';
import 'package:aldea/models/post_model.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/posts_carousel.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import '../../locator.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import "package:aldea/constants/icondata.dart" as custicon;
import 'like_button.dart';

class StartQuickstrike extends StatefulWidget {
  final PostModel postModel;
  final Function likeFunction;
  final Function goToCommunity;
  final bool isLiked;
  final Function goToComments;
  final Function deletePost;
  final bool deleteAllowed;
  const StartQuickstrike(
      {Key key,
      this.postModel,
      this.likeFunction,
      this.isLiked,
      this.goToComments,
      this.goToCommunity,
      this.deletePost,
      this.deleteAllowed})
      : super(key: key);

  @override
  _StartQuickstrikeState createState() => _StartQuickstrikeState();
}

class _StartQuickstrikeState extends State<StartQuickstrike> {
  final user = locator<User>();
  String readTimestamp(int timestamp) {
    var format = DateFormat('dd/M/yy');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date).toString();
  }

  var showingDelete = false;

  @override
  Widget build(BuildContext context) {
    String quickstrikeType = "Lista";
    String dayTime = "12:04, today";
    Color greyColor = Color(0xff3a464d);

    return Stack(
      children: [
        Container(
          color: custcolor.blueishGreyColor,
          width: devicesize.screenWidth(context),
          child: Column(
            children: <Widget>[
              Container(
                color: custcolor.loginColor,
                height: devicesize.screenHeight(context) * 0.2,
                width: devicesize.screenWidth(context),
                padding: EdgeInsets.only(
                    right: devicesize.screenWidth(context) * 0.067,
                    left: devicesize.screenWidth(context) * 0.067),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            color: Colors.purple,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                                offset: Offset(
                                  2.0,
                                  2.0,
                                ),
                              )
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://firebasestorage.googleapis.com/v0/b/aldea-dev-40685.appspot.com/o/users%2FwRCrNE3t8ne8h4pagZXYY8TFaHs1%2Fprofile%2FprofilePic1583145377119?alt=media&token=efd31978-9d91-4682-af35-106c9994e8de"),
                            radius: devicesize.screenWidth(context) * 0.07,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: devicesize.screenWidth(context) * 0.074),
                          child: Container(
                            width: devicesize.screenWidth(context) * 0.54,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Text(
                                      this.widget.postModel.communityName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Raleway',
                                          fontSize:
                                              devicesize.screenWidth(context) *
                                                  0.046,
                                          color: custcolor.almostWhite)),
                                ),
                                Text(
                                  //TODO: formatting daytime
                                  dayTime,
                                  style: TextStyle(
                                      color: Color(0xff3a464d),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Raleway',
                                      fontSize:
                                          devicesize.screenWidth(context) *
                                              0.035),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Container(
                          width: devicesize.screenWidth(context) * 0.86,
                          height: devicesize.screenHeight(context) * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: custcolor.darkBlue),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: devicesize.screenHeight(context) * 0.05,
                                width: devicesize.screenWidth(context) * 0.32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: custcolor.blueTheme,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        custicon.QuickStrike.quickstrike,
                                        color: custcolor.almostWhite,
                                      ),
                                      Text(
                                        "Quick",
                                        style: TextStyle(
                                            color: custcolor.almostWhite,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Raleway',
                                            fontSize: 20),
                                      )
                                    ]),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        devicesize.screenWidth(context) * 0.15),
                                child: Text(
                                  //TODO: formatting daytime
                                  readTimestamp(this
                                      .widget
                                      .postModel
                                      .fechaQuickstrike
                                      .seconds),
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: custcolor.almostWhite),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => widget.goToCommunity(),
                child: Container(
                    width: devicesize.screenWidth(context),
                    height: devicesize.screenHeight(context) * 0.362,
                    child: PostCarousel(
                      imageUrl: this.widget.postModel.imageUrl,
                    )),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: devicesize.screenWidth(context) * 0.045),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: devicesize.screenHeight(context) * 0.005),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${languages[user.language]["qs type"]}",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                color: custcolor.greyColor),
                          ),
                          Text(quickstrikeType,
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                  color: custcolor.blueTheme)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: devicesize.screenHeight(context) * 0.005),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "${languages[user.language]["model"]}: ",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                color: custcolor.greyColor),
                          ),
                          Text(widget.postModel.modelo,
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                  color: custcolor.blueTheme)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: devicesize.screenWidth(context) * 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${languages[user.language]["desc"]}: ",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                color: custcolor.greyColor),
                          ),
                          Flexible(
                            child: Text(widget.postModel.description,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                    color: custcolor.blueTheme)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: devicesize.screenHeight(context) * 0.02),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        devicesize.screenWidth(context) * 0.06,
                                    right:
                                        devicesize.screenWidth(context) * 0.138,
                                    bottom:
                                        devicesize.screenHeight(context) * 0.04,
                                  ),
                                  child: LikeButton(
                                    liked: widget.isLiked,
                                    likeFunction: widget.likeFunction,
                                    likes: this.widget.postModel.likes,
                                  )),
                              Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.comment,
                                    color: custcolor.blueTheme,
                                    size:
                                        devicesize.screenWidth(context) * 0.07,
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
                              widget.deleteAllowed
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        left: devicesize.screenWidth(context) *
                                            0.48,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size:
                                              devicesize.screenWidth(context) *
                                                  0.07,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            showingDelete = !showingDelete;
                                          });
                                        },
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        )
                      ],
                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
      ],
    );
  }
}
