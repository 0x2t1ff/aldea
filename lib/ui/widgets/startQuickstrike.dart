import 'package:aldea/models/post_model.dart';
import 'package:aldea/ui/widgets/posts_carousel.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import "package:aldea/constants/icondata.dart" as custicon;
import 'like_button.dart';

class StartQuickstrike extends StatelessWidget {
  final PostModel postModel;
  final Function likeFunction;
  final bool isLiked;
  final bool goToComments;
  const StartQuickstrike(
      {Key key,
      this.postModel,
      this.likeFunction,
      this.isLiked,
      this.goToComments})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    String quickstrikeType = "Lista";
    String dayTime = "12:04, today";
    Color greyColor = Color(0xff3a464d);

    return Container(
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
                              child: Text(this.postModel.communityName,
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
                                      devicesize.screenWidth(context) * 0.035),
                            ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      iconSize: devicesize.screenWidth(context) * 0.08,
                      icon: Icon(Icons.share),
                      onPressed: () =>
                          print("pressed but it ain't doing shit for now XD"),
                      color: custcolor.blueTheme,
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
                                left: devicesize.screenWidth(context) * 0.15),
                            child: Text(
                              //TODO: formatting daytime
                              readTimestamp(
                                  this.postModel.fechaQuickstrike.seconds),
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
          Container(
              width: devicesize.screenWidth(context),
              height: devicesize.screenHeight(context) * 0.362,
              child: PostCarousel(
                imageUrl: this.postModel.imageUrl,
              )),
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
                        "Tipo de Quickstrike:",
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
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: devicesize.screenWidth(context) * 0.04),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Descripción:",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: custcolor.greyColor),
                      ),
                      Flexible(
                        child: Text(postModel.description,
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
                                left: devicesize.screenWidth(context) * 0.06,
                                right: devicesize.screenWidth(context) * 0.138,
                                bottom: devicesize.screenHeight(context) * 0.04,
                              ),
                              child: LikeButton(
                                liked: isLiked,
                                likeFunction: likeFunction,
                                likes: this.postModel.likes,
                              )),
                          Column(
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
                                child: Text(postModel.commentCount.toString(),
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
                              left: devicesize.screenWidth(context) * 0.45,
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
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
