import 'package:aldea/models/post_model.dart';
import "package:flutter/material.dart";
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import "package:aldea/constants/icondata.dart" as custicon;
import "package:carousel_slider/carousel_slider.dart";

class FinishedQuickstrike extends StatefulWidget {
  final PostModel postModel;
  const FinishedQuickstrike({Key key, this.postModel}) : super(key: key);
  @override
  _FinishedQuickstrikeState createState() => _FinishedQuickstrikeState();
}

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

class _FinishedQuickstrikeState extends State<FinishedQuickstrike> {
  String quickstrikeType(bool game, bool random, bool lista) {
    if (game) {
      return "game";
    } else if (random) {
      return "random";
    } else {
      return "lista";
    }
  }

  Widget createWinnerRow(String winners) {
    return Padding(
      padding: EdgeInsets.only(top: 1),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Color(0xffDBE276),
          ),
          Text(
            winners,
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dayTime = "12:04, today";
    Color greyColor = Color(0xff3a464d);
    String commentText = "67";
    String likeText = "430";
    var winners = ["ucler", "jpavo", "MA", "isma-él", "esteve jaume"];

    List imageList = [
      "https://firebasestorage.googleapis.com/v0/b/aldea-dev-40685.appspot.com/o/communities%2Fpyschomods%2FWhatsApp%20Image%202020-02-26%20at%2011.15.43%20(1).jpeg?alt=media&token=6d64db39-b960-4aa5-8e22-c568293079f0",
      "https://firebasestorage.googleapis.com/v0/b/aldea-dev-40685.appspot.com/o/communities%2Fpyschomods%2FWhatsApp%20Image%202020-02-26%20at%2011.15.50%20(1).jpeg?alt=media&token=51a79564-096c-4fe7-a66f-a50ceb4e0d3e",
      "https://firebasestorage.googleapis.com/v0/b/aldea-dev-40685.appspot.com/o/communities%2Fpyschomods%2FWhatsApp%20Image%202020-02-26%20at%2011.15.50%20(2).jpeg?alt=media&token=ca7ca7af-946e-45c2-a988-0173447740da"
    ];
    return Container(
      color: custcolor.darkGrey,
      width: devicesize.screenWidth(context),
      height: devicesize.screenHeight(context) * 0.86 +
          devicesize.screenHeight(context) *
              0.02 *
              widget.postModel.winners.length,
      child: Column(
        children: <Widget>[
          Container(
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
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.postModel.avatarUrl),
                      radius: devicesize.screenWidth(context) * 0.06,
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
                              //TODO: format the daytime
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
            width: devicesize.screenWidth(context),
            height: devicesize.screenHeight(context) * 0.362,
            child: Stack(
              children: <Widget>[
                CarouselSlider.builder(
                  itemCount: imageList.length,
                  enableInfiniteScroll: false,
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
                            image: NetworkImage(imageList[itemIndex]),
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
                        ...imageList
                            .map((image) =>
                                countPointer(imageList.indexOf(image)))
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
                      vertical: devicesize.screenHeight(context) * 0.01),
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
                          quickstrikeType(
                              widget.postModel.isGame,
                              widget.postModel.isRandom,
                              widget.postModel.isLista),
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
                    Text(widget.postModel.modelo,
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: custcolor.blueTheme)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: devicesize.screenHeight(context) * 0.015),
                  child: Container(
                    width: devicesize.screenWidth(context) * 0.88,
                    height: devicesize.screenHeight(context) * 0.04 +
                        devicesize.screenHeight(context) *
                            0.031 *
                            widget.postModel.winners.length,
                    decoration: BoxDecoration(
                        color: custcolor.greenTheme,
                        borderRadius: BorderRadius.circular(25)),
                    child: Column(children: <Widget>[
                      Text(
                        "Enhorabuena a los ganadores!",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: devicesize.screenHeight(context) *
                                0.033 *
                                widget.postModel.winners.length ,
                            width: devicesize.screenWidth(context) * 0.4,
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
                                        itemCount: winners.length,
                                        itemBuilder:
                                            (BuildContext ctx, int index) {
                                          return createWinnerRow(
                                              widget.postModel.winners[index]);
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(                            
                            width: devicesize.screenWidth(context) * 0.27,
                            alignment: Alignment.center,
                            child: Container(
                                width: devicesize.screenWidth(context) * 0.07 +
                                    devicesize.screenWidth(context) *
                                        0.04 *
                                        widget.postModel.winners.length,
                                height: devicesize.screenWidth(context) * 0.07 +
                                    devicesize.screenWidth(context) *
                                        0.04 *
                                        widget.postModel.winners.length,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        AssetImage("assets/images/trophy.png"),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ],),
                  ),
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
                                    size:
                                        devicesize.screenWidth(context) * 0.07,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: devicesize.screenHeight(context) *
                                            0.005),
                                    child: Text(
                                      likeText,
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
                                  child: Text(commentText,
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
                                left: devicesize.screenWidth(context) * 0.455,
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
          )
        ],
      ),
    );
  }
}
