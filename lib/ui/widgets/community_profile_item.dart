import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/shared_styles.dart';
import 'package:flutter/material.dart';
import '../shared/ui_helpers.dart' as devicesize;
import '../shared/app_colors.dart' as custcolor;

class CommunityProfileItem extends StatefulWidget {
  final Community community;
  final int index;
  const CommunityProfileItem({Key key, this.community, this.index})
      : super(key: key);

  @override
  _CommunityProfileItemState createState() => _CommunityProfileItemState();
}

class _CommunityProfileItemState extends State<CommunityProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: devicesize.screenWidth(context),
        height: devicesize.screenHeight(context) * 0.103,
        color: widget.index % 2 == 0
            ? custcolor.backgroundColor
            : custcolor.loginColor,
        child: Row(children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: devicesize.screenWidth(context) * 0.045),
            child: Container(
              decoration: quickstrikePicDecoration,
              child: CircleAvatar(
                radius: devicesize.screenWidth(context) * 0.065,
                backgroundImage: NetworkImage(widget.community.iconPicUrl),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: devicesize.screenWidth(context) * 0.045,
                top: devicesize.screenHeight(context) * 0.015),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.community.name,
                  style: TextStyle(
                    color: custcolor.almostWhite,
                    fontSize: devicesize.screenHeight(context) * 0.021,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: devicesize.screenHeight(context) * 0.01),
                  width: devicesize.screenWidth(context) * 0.7,
                  height: devicesize.screenHeight(context) * 0.0629,
                  child: Text(
                    widget.community.description,
                    style: TextStyle(
                      color: custcolor.grey,
                      fontSize: devicesize.screenHeight(context) * 0.017,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    ]);
  }
}
