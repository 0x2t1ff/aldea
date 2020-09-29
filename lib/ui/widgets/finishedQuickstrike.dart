import 'dart:ui';

import 'package:aldea/constants/languages.dart';
import 'package:aldea/locator.dart';
import 'package:aldea/models/post_model.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/like_button.dart';
import 'package:aldea/ui/widgets/posts_carousel.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import "package:aldea/constants/icondata.dart" as custicon;

class FinishedQuickstrike extends StatefulWidget {
  final PostModel postModel;
  final Function navigateToComments;
  final Function likeFunction;
  final Function goToCommunity;
  final bool isLiked;
  final bool allowedDelete;
  final Function deletePost;
  const FinishedQuickstrike(
      {Key key,
      this.postModel,
      this.likeFunction,
      this.isLiked,
      this.navigateToComments,
      this.goToCommunity,
      this.allowedDelete,
      this.deletePost})
      : super(key: key);

  @override
  _FinishedQuickstrikeState createState() => _FinishedQuickstrikeState();
}

class _FinishedQuickstrikeState extends State<FinishedQuickstrike> {
  final user = locator<User>();
  String quickstrikeType(bool game, bool random, bool lista) {
    if (game) {
      return languages[user.language]["game"];
    } else if (random) {
      return languages[user.language]["random"];
    } else {
      return languages[user.language]["list"];
    }
  }

  String readTimestamp(int timestamp) {
    var format = DateFormat('dd/M/yy');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format.format(date).toString();
  }

  Widget createWinnerRow(String winners, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Color(0xffDBE276),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: devicesize.screenWidth(context) * 0.01),
            child: Text(
              winners,
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w700,
                  color: custcolor.almostWhite),
            ),
          )
        ],
      ),
    );
  }

  bool showingDelete = false;
  @override
  Widget build(BuildContext context) {
    String dayTime = readTimestamp(widget.postModel.fechaQuickstrike.seconds);
    Color greyColor = Color(0xff3a464d);

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: custcolor.loginColor,
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
            children: <Widget>[
              Container(
                color: custcolor.blueishGreyColor,
                height: devicesize.screenHeight(context) * 0.18,
                width: devicesize.screenWidth(context),
                padding: EdgeInsets.only(
                  right: devicesize.screenWidth(context) * 0.067,
                  left: devicesize.screenWidth(context) * 0.067,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () => widget.goToCommunity(),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.postModel.avatarUrl),
                            radius: devicesize.screenWidth(context) * 0.065,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: devicesize.screenWidth(context) * 0.074),
                          child: Container(
                            width: devicesize.screenWidth(context) * 0.52,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Text(widget.postModel.communityName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Raleway',
                                          fontSize:
                                              devicesize.screenWidth(context) *
                                                  0.046,
                                          color: custcolor.almostWhite)),
                                ),
                                Text(
                                  //TODO: format the daytime
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
                    Container(
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
                                color: custcolor.greenTheme,
                              ),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Icon(custicon.QuickStrike.quickstrike,
                                        color: custcolor.almostWhite),
                                    Text("Quick",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w600,
                                            color: custcolor.almostWhite))
                                  ]),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: devicesize.screenWidth(context) * 0.15),
                              child: Text(
                                languages[user.language]["winners"],
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                    color: custcolor.almostWhite),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              Container(
                height: devicesize.screenHeight(context) * 0.362,
                child: PostCarousel(imageUrl: this.widget.postModel.imageUrl),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: devicesize.screenWidth(context) * 0.045),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: devicesize.screenHeight(context) * 0.02,
                          bottom: devicesize.screenHeight(context) * 0.01),
                      child: Row(
                        children: <Widget>[
                          Text(
                            languages[user.language]["qs type"],
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                color: custcolor.greyColor),
                          ),
                          Text(
                              quickstrikeType(
                                  widget.postModel.isGame,
                                  widget.postModel.isRandom,
                                  widget.postModel.isLista),
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w600,
                                  color: custcolor.blueTheme)),
                        ],
                      ),
                    ),
                    Row(
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
                    Padding(
                      padding: EdgeInsets.only(
                          top: devicesize.screenHeight(context) * 0.02),
                      child: Container(
                        width: devicesize.screenWidth(context) * 0.9,
                        height: devicesize.screenHeight(context) * 0.08 +
                            devicesize.screenHeight(context) *
                                0.031 *
                                widget.postModel.winners.length,
                        decoration: BoxDecoration(
                            color: custcolor.greenTheme,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: devicesize.screenWidth(context) * 0.06,
                                  top: devicesize.screenHeight(context) * 0.02,
                                  bottom:
                                      devicesize.screenHeight(context) * 0.005),
                              child: Text(
                                languages[user.language]["congrats"],
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w800,
                                    fontSize:
                                        devicesize.screenWidth(context) * 0.04),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: devicesize.screenWidth(context) *
                                          0.06),
                                  child: Container(
                                    height: devicesize.screenHeight(context) *
                                        0.033 *
                                        widget.postModel.winners.length,
                                    width:
                                        devicesize.screenWidth(context) * 0.58,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: SizedBox(
                                            //   width:
                                            //          devicesize.screenWidth(context) * 0.88,
                                            //     height:
                                            //     devicesize.screenHeight(context) * 0.4,
                                            child: ListView.builder(
                                                padding:
                                                    EdgeInsets.only(top: 2),
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: widget
                                                    .postModel.winners.length,
                                                itemBuilder: (BuildContext ctx,
                                                    int index) {
                                                  return createWinnerRow(
                                                    "Javi Moreno",
                                                    context,
                                                  );
                                                  // postModel.winners[index]);
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: devicesize.screenWidth(context) * 0.25,
                                  alignment: Alignment.center,
                                  child: Container(
                                      width: devicesize.screenWidth(context) *
                                              0.07 +
                                          devicesize.screenWidth(context) *
                                              0.04 *
                                              widget.postModel.winners.length,
                                      height: devicesize.screenWidth(context) *
                                              0.07 +
                                          devicesize.screenWidth(context) *
                                              0.04 *
                                              widget.postModel.winners.length,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              "assets/images/trophy.png"),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        child: Padding(
                      padding: EdgeInsets.only(
                          top: devicesize.screenHeight(context) * 0.01,
                          bottom: devicesize.screenHeight(context) * 0.01),
                      child: Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                left: devicesize.screenWidth(context) * 0.06,
                                right: devicesize.screenWidth(context) * 0.138,
                              ),
                              child: LikeButton(
                                likes: widget.postModel.likes,
                                likeFunction: widget.likeFunction,
                                liked: widget.isLiked,
                              )),
                          Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: widget.navigateToComments,
                                child: Icon(
                                  Icons.comment,
                                  color: custcolor.blueTheme,
                                  size: devicesize.screenWidth(context) * 0.07,
                                ),
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
                          widget.allowedDelete
                              ? Padding(
                                  padding: EdgeInsets.only(
                                    left:
                                        devicesize.screenWidth(context) * 0.44,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: devicesize.screenWidth(context) *
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
                    )),
                  ],
                ),
              )
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
