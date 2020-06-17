import 'package:aldea/models/comment_model.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final CommentModel model;
  const CommentWidget(this.model);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: darkGrey,
      width: screenWidth(context),
      child: Container(
        width: screenWidth(context),
        margin: EdgeInsets.symmetric(
            horizontal: screenWidth(context) * 0.04,
            vertical: screenWidth(context) * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: screenHeight(context) * 0.01),
              child: Text(
                model.name,
                style: TextStyle(
                    color: blueTheme,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              model.text,
              style: TextStyle(color: almostWhite, fontFamily: 'Raleway'),
            ),
            Padding(
              padding: EdgeInsets.only(top: screenHeight(context) * 0.01),
              child: Text(model.date.toString().substring(0, 16),
                  style: TextStyle(
                    color: greyColor,
                    fontFamily: 'Raleway',
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
