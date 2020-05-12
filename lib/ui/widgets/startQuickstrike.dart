import 'package:aldea/models/post_model.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import "package:aldea/constants/icondata.dart" as custicon;
import "package:carousel_slider/carousel_slider.dart";

import 'adaptive_text.dart';
import 'finishedQuickstrike.dart';

class StartQuickstrike extends StatefulWidget {
     final PostModel postModel;
  const StartQuickstrike({Key key, this.postModel}) : super(key: key);
  @override
  _StartQuickstrikeState createState() => _StartQuickstrikeState();
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
      
    }else if(diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 1){
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
int _current = 0;

class _StartQuickstrikeState extends State<StartQuickstrike> {
  @override
  Widget build(BuildContext context) {
    String quickstrikeType = "Lista";
    String dayTime = "12:04, today";
    Color greyColor = Color(0xff3a464d);
    
    

    return Container(
      color: custcolor.darkGrey,
      width: devicesize.screenWidth(context),
      child: Column(
        children: <Widget>[
          Container(
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
                        radius: devicesize.screenWidth(context) * 0.06,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: devicesize.screenWidth(context) * 0.074),
                      child: Container(
                        width: devicesize.screenWidth(context) * 0.55,
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
                              //TODO: formatting daytime
                              dayTime,
                              style: TextStyle(
                                  color: Color(0xff3a464d),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Raleway',
                                  fontSize:
                                      devicesize.screenWidth(context) * 0.03),
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
                            readTimestamp( widget.postModel.fechaQuickstrike.seconds),
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
            child: Stack(
              children: <Widget>[
                CarouselSlider.builder(
                  itemCount: widget.postModel.imageUrl.length,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  aspectRatio: 4 / 3,
                  onPageChanged: (index) {
                    setState(() {
                      _current = index;
                    });
                  },
                  height: devicesize.screenHeight(context) * 0.4,
                  itemBuilder: (BuildContext context, int itemIndex) =>
                      Container(
                    width: devicesize.screenWidth(context),
                    height: devicesize.screenHeight(context) * 0.4,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.postModel.imageUrl[itemIndex]),
                            fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  top: devicesize.screenHeight(context) * 0.31,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ...widget.postModel.imageUrl
                            .map((image) =>
                                countPointer(widget.postModel.imageUrl.indexOf(image)))
                            .toList()
                      ]),
                )
              ],
            ),
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
                  padding:  EdgeInsets.only(bottom: devicesize.screenHeight(context) * 0.005),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Modelo:",
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
                Row(
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
                      child: Text(widget.postModel.description,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              color: custcolor.blueTheme)),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: devicesize.screenHeight(context) * 0.02),
                      child: Container(
                        padding: EdgeInsets.only(
                            left: devicesize.screenWidth(context) * 0.02),
                        width: devicesize.screenWidth(context) * 0.88,
                        height: devicesize.screenHeight(context) * 0.035,
                        decoration: BoxDecoration(
                          color: Color(0xff15232B),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.edit,
                              size: 16,
                              color: Color(0xff3a464d),
                            ),
                            hintText: "Escribe un comentario",
                            hintStyle: TextStyle(
                                color: Color(0xff3a464d),
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                fontSize: 12),
                            border: InputBorder.none,
                            fillColor: custcolor.almostWhite,
                          ),
                          style:  TextStyle(
                          color: custcolor.almostWhite,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                        ),
                      ),
                    ),
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
                                Icon(
                                  Icons.favorite,
                                  color: custcolor.blueTheme,
                                  size: devicesize.screenWidth(context) * 0.07,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: devicesize.screenHeight(context) *
                                          0.005),
                                  child: Text(
                                    widget.postModel.likes.toString(),
                                    style: TextStyle(
                                        color: greyColor,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                child: Text(widget.postModel.comments.length.toString(),
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
