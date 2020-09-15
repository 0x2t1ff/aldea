import 'package:aldea/models/post_model.dart';
import 'package:aldea/ui/widgets/like_button.dart';
import 'package:aldea/ui/widgets/posts_carousel.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import "package:aldea/constants/icondata.dart" as custicon;

class FinishedQuickstrike extends StatelessWidget {
  final PostModel postModel;
  final Function navigateToComments;
  final Function likeFunction;
  final Function goToCommunity;
  final bool isLiked;
  const FinishedQuickstrike(
      {Key key,
      this.postModel,
      this.likeFunction,
      this.isLiked,
      this.navigateToComments,
      this.goToCommunity})
      : super(key: key);

  String quickstrikeType(bool game, bool random, bool lista) {
    if (game) {
      return "game";
    } else if (random) {
      return "random";
    } else {
      return "lista";
    }
  }

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

  @override
  Widget build(BuildContext context) {
    String dayTime = readTimestamp(postModel.fechaQuickstrike.seconds);
    Color greyColor = Color(0xff3a464d);

    return Container(
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
                      onTap:() => goToCommunity(),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(postModel.avatarUrl),
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
                              child: Text(postModel.communityName,
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
                                      devicesize.screenWidth(context) * 0.035),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            "¡Ganadores!",
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
            child: PostCarousel(imageUrl: this.postModel.imageUrl),
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
                        "Tipo de Quickstrike:",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: custcolor.greyColor),
                      ),
                      Text(
                          quickstrikeType(postModel.isGame, postModel.isRandom,
                              postModel.isLista),
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
                      "Modelo:",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w600,
                          color: custcolor.greyColor),
                    ),
                    Text(postModel.modelo,
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
                            postModel.winners.length,
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
                              bottom: devicesize.screenHeight(context) * 0.005),
                          child: Text(
                            "Enhorabuena a los ganadores!",
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
                                  left: devicesize.screenWidth(context) * 0.06),
                              child: Container(
                                height: devicesize.screenHeight(context) *
                                    0.033 *
                                    postModel.winners.length,
                                width: devicesize.screenWidth(context) * 0.58,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: SizedBox(
                                        //   width:
                                        //          devicesize.screenWidth(context) * 0.88,
                                        //     height:
                                        //     devicesize.screenHeight(context) * 0.4,
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(top: 2),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: postModel.winners.length,
                                            itemBuilder:
                                                (BuildContext ctx, int index) {
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
                                  width:
                                      devicesize.screenWidth(context) * 0.07 +
                                          devicesize.screenWidth(context) *
                                              0.04 *
                                              postModel.winners.length,
                                  height:
                                      devicesize.screenWidth(context) * 0.07 +
                                          devicesize.screenWidth(context) *
                                              0.04 *
                                              postModel.winners.length,
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
                            likes: postModel.likes,
                            likeFunction: likeFunction,
                            liked: isLiked,
                          )),
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: navigateToComments,
                            child: Icon(
                              Icons.comment,
                              color: custcolor.blueTheme,
                              size: devicesize.screenWidth(context) * 0.07,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: devicesize.screenHeight(context) * 0.005),
                            child: Text(
                                postModel.commentCount == null
                                    ? "0"
                                    : postModel.commentCount.toString(),
                                style: TextStyle(
                                    color: greyColor,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14)),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: devicesize.screenWidth(context) * 0.43,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.more_vert,
                            color: custcolor.blueTheme,
                            size: devicesize.screenWidth(context) * 0.07,
                          ),
                          onPressed: () => print("pressed"),
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
