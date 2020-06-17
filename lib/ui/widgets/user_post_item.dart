import 'package:aldea/models/user_post_model.dart';
import 'package:aldea/ui/widgets/like_button.dart';
import 'package:aldea/ui/widgets/posts_carousel.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import 'adaptive_text.dart';

class UserPostItem extends StatelessWidget {
  final UserPostModel postModel;
  final Function likeFunction;
  final Function goToComments;
  final Function navigate;
  final bool isLiked;
  final String uid;
  const UserPostItem(
      {Key key,
      this.postModel,
      this.goToComments,
      this.likeFunction,
      this.isLiked,
      this.navigate,
      this.uid})
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
    bool liked = isLiked;
    String dayTime = readTimestamp(postModel.date.seconds);
    Color greyColor = Color(0xff3a464d);
    return Container(
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
                    onTap: navigate,
                    child: CircleAvatar(
                      radius: devicesize.screenWidth(context) * 0.06,
                      backgroundImage: NetworkImage(postModel.avatarUrl),
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
                          child: Text(postModel.name,
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
                              fontSize: devicesize.screenWidth(context) * 0.03),
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
            height: postModel.imageUrl.isEmpty == true
                ? 0
                : devicesize.screenHeight(context) * 0.4,
            child: postModel.imageUrl.isEmpty == true
                ? Container()
                : PostCarousel(imageUrl: postModel.imageUrl),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: devicesize.screenWidth(context) * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                AdaptiveText(
                  postModel.description,
                  95,
                  TextStyle(
                      fontFamily: "Raleway",
                      color: custcolor.almostWhite,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                      fontSize: 14),
                ),
              ],
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
                              likeFunction: likeFunction,
                              liked: liked,
                              likes: postModel.likes,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: goToComments,
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.comment,
                              color: custcolor.blueTheme,
                              size: devicesize.screenWidth(context) * 0.07,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      devicesize.screenHeight(context) * 0.005),
                              child: Text(postModel.commentCount.toString(),
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
                          left: devicesize.screenWidth(context) * 0.545,
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
          ),
        ],
      ),
    );
  }
}
