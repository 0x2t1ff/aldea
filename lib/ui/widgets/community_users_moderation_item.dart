import 'package:aldea/models/community.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/shared_styles.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';

class CommunityUsersModerationItem extends StatefulWidget {
  final User user;
  final int index;
  final Community community;
  final Function kickMember;
  final Function promoteMember;
  const CommunityUsersModerationItem(
      {Key key,
      this.user,
      this.index,
      this.community,
      this.kickMember,
      this.promoteMember})
      : super(key: key);

  @override
  _VouchItemState createState() => _VouchItemState();
}

class _VouchItemState extends State<CommunityUsersModerationItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: screenHeight(context) * 0.103,
      color: widget.index % 2 == 0 ? backgroundColor : darkGrey,
      child: Row(children: <Widget>[
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.045),
          child: Container(
            decoration: quickstrikePicDecoration,
            child: CircleAvatar(
              radius: screenWidth(context) * 0.065,
              backgroundImage: NetworkImage(widget.user.picUrl),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.remove_from_queue, color: Colors.red),
              onPressed: widget.kickMember,
            ),
            Text(
              widget.user.name,
              style: TextStyle(
                color: almostWhite,
                fontSize: 20,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              icon: Icon(Icons.remove_circle, color: blueTheme),
              onPressed:
                widget.promoteMember
            ),
          ],
        )
      ]),
    );
  }
}
