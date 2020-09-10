import 'package:aldea/models/user_model.dart';
import 'package:aldea/ui/shared/shared_styles.dart';
import 'package:flutter/material.dart';
import '../shared/ui_helpers.dart' as devicesize;
import '../shared/app_colors.dart' as custcolor;

class VouchItem extends StatefulWidget {
  final User vouch;
  final Function goToProfile;
  final int index;
  const VouchItem({Key key, this.vouch, this.index, this.goToProfile}) : super(key: key);

  @override
  _VouchItemState createState() => _VouchItemState();
}

class _VouchItemState extends State<VouchItem> {
  String animationSelector = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
     GestureDetector(onTap: (){
       widget.goToProfile();
     },
            child: Container(
          width: devicesize.screenWidth(context),
          height: devicesize.screenHeight(context) * 0.103,
          color: widget.index % 2 == 0
              ? custcolor.backgroundColor
              : custcolor.darkGrey,
          child: Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: devicesize.screenWidth(context) * 0.045),
              child:Container(
                  decoration: quickstrikePicDecoration,
                  child: CircleAvatar(
                    radius: devicesize.screenWidth(context) * 0.065,
                    backgroundImage: NetworkImage(widget.vouch.picUrl),
                  ),
                ),
              ),
           
            Padding(
              padding:
                  EdgeInsets.only(left: devicesize.screenWidth(context) * 0.045),
              child: Text(
                widget.vouch.name,
                style: TextStyle(
                  color: custcolor.almostWhite,
                  fontSize: 20,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ]),
        ),
     ),
    ]);
  }
}
