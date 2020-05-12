import 'package:aldea/models/post_model.dart';
import "package:flutter/material.dart";
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import "package:aldea/constants/icondata.dart" as custicon;
import "package:carousel_slider/carousel_slider.dart";

import 'adaptive_text.dart';
import 'finishedQuickstrike.dart';

class PostItem extends StatefulWidget {
  final PostModel postModel;
  const PostItem({Key key, this.postModel}) : super(key: key);
  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  Widget countPointer(int index) {
    return Container(
      width: 10.0,
      height: 10.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _current == index
            ? Colors.white.withOpacity(0.8)
            : Colors.grey.withOpacity(0.8),
      ),
    );
  }

  int _current = 0;
  @override
  Widget build(BuildContext context) {
    bool isAnnouncement = false;
    bool isResult = true;
    bool isPost = true;
    String quickstrikeType = "Lista";

    String dayTime = "12:04, today";
    Color greyColor = Color(0xff3a464d);
    String commentText = "67";
    String likeText = "430";
    String itemType = "Eagle 2.0 - 5 ganadores";
    var winners = ["Eskere Jaume", "Isma-él", "ucler", "MA"];

    List imageList = [
      "https://firebasestorage.googleapis.com/v0/b/aldea-dev-40685.appspot.com/o/communities%2Fpyschomods%2FWhatsApp%20Image%202020-02-26%20at%2011.15.43%20(1).jpeg?alt=media&token=6d64db39-b960-4aa5-8e22-c568293079f0",
      "https://firebasestorage.googleapis.com/v0/b/aldea-dev-40685.appspot.com/o/communities%2Fpyschomods%2FWhatsApp%20Image%202020-02-26%20at%2011.15.50%20(1).jpeg?alt=media&token=51a79564-096c-4fe7-a66f-a50ceb4e0d3e",
      "https://firebasestorage.googleapis.com/v0/b/aldea-dev-40685.appspot.com/o/communities%2Fpyschomods%2FWhatsApp%20Image%202020-02-26%20at%2011.15.50%20(2).jpeg?alt=media&token=ca7ca7af-946e-45c2-a988-0173447740da"
    ];
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
            height: devicesize.screenHeight(context) * 0.11,
            color: Colors.red,
          ),
          Container(
            width: devicesize.screenWidth(context),
            height: devicesize.screenHeight(context) * 0.11,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      left: devicesize.screenWidth(context) * 0.06),
                  child: CircleAvatar(
                    radius: devicesize.screenWidth(context) * 0.06,
                    backgroundImage: NetworkImage(widget.postModel.avatarUrl),
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
                          child: Text(widget.postModel.communityName,
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
            height: devicesize.screenHeight(context) * 0.4,
            child: Stack(
              children: <Widget>[
                CarouselSlider.builder(
                  enableInfiniteScroll: false,
                  itemCount: widget.postModel.imageUrl.length,
                  viewportFraction: 1.0,
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
                            image: NetworkImage(
                                widget.postModel.imageUrl[itemIndex]),
                            fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  top: devicesize.screenHeight(context) * 0.35,
                  left: 0.0,
                  right: 0.0,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ...widget.postModel.imageUrl
                            .map((image) => countPointer(
                                widget.postModel.imageUrl.indexOf(image)))
                            .toList()
                      ]),
                )
              ],
            ),
          ),
          AdaptiveText(
            widget.postModel.description,
            95,
            TextStyle(
                fontFamily: "Raleway",
                color: custcolor.almostWhite,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
                fontSize: 14),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      ),
                      style: TextStyle(
                          color: custcolor.almostWhite,
                          fontFamily: "Raleway",
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: devicesize.screenHeight(context) * 0.01),
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
                                  top:
                                      devicesize.screenHeight(context) * 0.005),
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
                                top: devicesize.screenHeight(context) * 0.005),
                            child: Text(
                                widget.postModel.comments.length.toString(),
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
