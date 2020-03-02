import 'dart:ui';

import 'package:aldea/ui/shared/google_navbar.dart';
import 'package:flutter/material.dart';
import "../shared/ui_helpers.dart" as devicesize;
import "package:aldea/constants/icondata.dart" as custicon;

class QuickStrikeCreationPanel extends StatelessWidget {
  final typeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool quickStrikeForm = false;
    var blackColor = Colors.black;
    return Container(
      padding: EdgeInsets.only(left: 0),
      height: devicesize.screenHeight(context) * 0.7278,
      width: devicesize.screenWidth(context) * 0.824,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(devicesize.screenWidth(context) * 0.08),
        color: Color.fromRGBO(100, 100, 100, 0.23),
        //image: DecorationImage(
        //  image: AssetImage("assets/images/whitebackground.jpg"),
        //
        //),
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
          child: quickStrikeForm
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: devicesize.screenHeight(context) * 0.027),
                            child: Container(
                                width: devicesize.screenWidth(context) * 0.6898,
                                height:
                                    devicesize.screenHeight(context) * 0.0591,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20, top: 10),
                                  child: Text(
                                    "Publicar",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: devicesize.screenHeight(context) * 0.027),
                            child: Container(
                                height:
                                    devicesize.screenHeight(context) * 0.0591,
                                width: devicesize.screenWidth(context) * 0.37,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Text(
                                    "QuickStrike",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: devicesize.screenHeight(context) * 0.0221),
                      child: Container(
                        width: devicesize.screenWidth(context) * 0.682,
                        height: 2,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(" Opciones",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              fontSize: 22)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: devicesize.screenWidth(context) * 0.694,
                        height: devicesize.screenHeight(context) * 0.211,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print("se ha pulsado");
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: devicesize.screenWidth(context) * 0.613,
                                height:
                                    devicesize.screenHeight(context) * 0.0296,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: devicesize.screenWidth(context) *
                                          0.189,
                                      height: devicesize.screenHeight(context) *
                                          0.0296,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Text(
                                        "Cantidad",
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left:
                                              devicesize.screenWidth(context) *
                                                  0.35),
                                      child: Icon(
                                        Icons.expand_more,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      left: devicesize.screenWidth(context) *
                                          0.2),
                                  width:
                                      devicesize.screenWidth(context) * 0.613,
                                  height:
                                      devicesize.screenHeight(context) * 0.0296,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: new TextFormField(
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.grey,
                                    ),
                                    style: new TextStyle(
                                      fontFamily: "Raleway",
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      devicesize.screenWidth(context) * 0.189,
                                  height:
                                      devicesize.screenHeight(context) * 0.0296,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    "Tipo",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(
                                      left: devicesize.screenWidth(context) *
                                          0.2),
                                  width:
                                      devicesize.screenWidth(context) * 0.613,
                                  height:
                                      devicesize.screenHeight(context) * 0.0296,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: new TextFormField(
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: Colors.grey,
                                    ),
                                    style: new TextStyle(
                                      fontFamily: "Raleway",
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      devicesize.screenWidth(context) * 0.189,
                                  height:
                                      devicesize.screenHeight(context) * 0.0296,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    "Modelo",
                                    style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                print("se ha pulsado");
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: devicesize.screenWidth(context) * 0.613,
                                height:
                                    devicesize.screenHeight(context) * 0.0296,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: devicesize.screenWidth(context) *
                                          0.189,
                                      height: devicesize.screenHeight(context) *
                                          0.0296,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Text(
                                        "Fecha",
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Text(
                        "Descripción",
                        style: TextStyle(
                            fontSize: 21,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: devicesize.screenWidth(context) * 0.52,
                          height: devicesize.screenHeight(context) * 0.171,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                child: Container(
                                  width:
                                      devicesize.screenWidth(context) * 0.139,
                                  height:
                                      devicesize.screenHeight(context) * 0.053,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.more, color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: GestureDetector(
                                  child: Container(
                                    width:
                                        devicesize.screenWidth(context) * 0.139,
                                    height: devicesize.screenHeight(context) *
                                        0.053,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child:
                                        Icon(Icons.more, color: Colors.white),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width:
                                      devicesize.screenWidth(context) * 0.139,
                                  height:
                                      devicesize.screenHeight(context) * 0.053,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.more, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: GestureDetector(
                        child: Container(
                          height: devicesize.screenHeight(context) * 0.0567,
                          width: devicesize.screenWidth(context) * 0.2824,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black,
                                  offset: Offset(8.0, 8.0),
                                  blurRadius: 10)
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Listo",
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                              Icon(
                                custicon.QuickStrike.quickstrike,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: devicesize.screenHeight(context) * 0.027),
                            child: Container(
                                width: devicesize.screenWidth(context) * 0.6898,
                                height:
                                    devicesize.screenHeight(context) * 0.0591,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: EdgeInsets.only(right: 145, top: 10),
                                  child: Text(
                                    "QuickStrike",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600),
                                  ),
                                )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: devicesize.screenHeight(context) * 0.027,
                                left: 150),
                            child: Container(
                                height:
                                    devicesize.screenHeight(context) * 0.0591,
                                width: devicesize.screenWidth(context) * 0.37,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 35, top: 10),
                                  child: Text(
                                    "Publicar",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Raleway',
                                      color: Colors.black,
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        color: Colors.white,
                        width: devicesize.screenWidth(context) * 0.6898,
                        height: 2,
                      ),
                    ),
                    Text(
                      "Descripción",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Raleway',
                          color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: devicesize.screenHeight(context) * 0.03,
                          bottom:  devicesize.screenHeight(context) * 0.03),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        width: devicesize.screenWidth(context) * 0.685,
                        height: devicesize.screenHeight(context) * 0.312,
                        decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Escribe una descripción...",
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w600,
                                fontSize: 16),
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                            fillColor: Colors.grey,
                          ),
                          style: TextStyle(
                              fontFamily: "Raleway", color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                          width: devicesize.screenWidth(context) * 0.1851,
                          height: devicesize.screenHeight(context) * 0.11,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 60,),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                          width: devicesize.screenWidth(context) * 0.1851,
                          height: devicesize.screenHeight(context) * 0.11,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 60,),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                          width: devicesize.screenWidth(context) * 0.1851,
                          height: devicesize.screenHeight(context) * 0.11,
                          decoration: BoxDecoration(
                            color: blackColor,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 60,),
                          ),
                        )
                      ],
                    )
                  ],
                )),
    );
  }
}
