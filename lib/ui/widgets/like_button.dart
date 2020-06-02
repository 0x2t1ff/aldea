import 'package:flutter/material.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;

class LikeButton extends StatefulWidget {
  final Function likeFunction;
  final List likes;
  final bool liked;
  const LikeButton({this.likeFunction, this.liked, this.likes});
  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;
  @override
  void initState() {
    isLiked = widget.liked;
    likeCount = widget.likes.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              isLiked ? likeCount-- : likeCount++;
              widget.likeFunction();
              isLiked = !isLiked;
            });
          },
          child: Icon(
            Icons.favorite,
            color: isLiked ? Colors.red : custcolor.blueTheme,
            size: devicesize.screenWidth(context) * 0.07,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: devicesize.screenHeight(context) * 0.005),
          child: Text(
            likeCount.toString(),
            style: TextStyle(
                color: Color(0xff3a464d),
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
        ),
      ],
    );
  }
}
