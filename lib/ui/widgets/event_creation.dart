import 'dart:ui';
import 'package:aldea/ui/widgets/quickstrike_creation.dart';

import 'package:aldea/ui/widgets/post_creation.dart';
import 'package:flutter/material.dart';
import "../shared/ui_helpers.dart" as devicesize;

import "../shared/app_colors.dart" as custcolor;

class EventCreationPanel extends StatefulWidget {
  @override
  _EventCreationPanelState createState() => _EventCreationPanelState();
}

class _EventCreationPanelState extends State<EventCreationPanel> {
  final typeController = TextEditingController();
  final desceriptionController  = TextEditingController();
  final amountController = TextEditingController();


  
  bool quickStrikeForm = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: devicesize.screenHeight(context) * 0.7278,
        width: devicesize.screenWidth(context) * 0.824,
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(devicesize.screenWidth(context) * 0.08),
          color: Color.fromRGBO(100, 100, 100, 0.23),
        ),
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Column(
              children: <Widget>[
                quickStrikeForm
                    ? Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => setState(() {
                              quickStrikeForm = !quickStrikeForm;
                              print("cambia el formulario xfas");
                            }),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      devicesize.screenHeight(context) * 0.027),
                              child: Container(
                                  width:
                                      devicesize.screenWidth(context) * 0.6898,
                                  height:
                                      devicesize.screenHeight(context) * 0.0591,
                                  decoration: BoxDecoration(
                                      color: custcolor.almostBlack,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 20, top: 10),
                                    child: Text(
                                      "Publicar",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: custcolor.almostWhite,
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
                                  top:
                                      devicesize.screenHeight(context) * 0.027),
                              child: Container(
                                  height:
                                      devicesize.screenHeight(context) * 0.0591,
                                  width: devicesize.screenWidth(context) * 0.37,
                                  decoration: BoxDecoration(
                                      color: custcolor.almostWhite,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10, top: 10),
                                    child: Text(
                                      "QuickStrike",
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Raleway',
                                        color: custcolor.almostBlack,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => setState(() {
                              print("cambia el formulario xfa");
                              quickStrikeForm = !quickStrikeForm;
                            }),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top:
                                      devicesize.screenHeight(context) * 0.027),
                              child: Container(
                                width: devicesize.screenWidth(context) * 0.6898,
                                height:
                                    devicesize.screenHeight(context) * 0.0591,
                                decoration: BoxDecoration(
                                    color:custcolor.almostBlack,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: devicesize.screenHeight(context) *
                                          0.178,
                                      top: devicesize.screenHeight(context) *
                                          0.012),
                                  child: Text(
                                    "QuickStrike",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        color: custcolor.almostWhite,
                                        fontSize:
                                            devicesize.screenHeight(context) *
                                                0.027,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: devicesize.screenHeight(context) * 0.027,
                                  left:
                                      devicesize.screenHeight(context) * 0.185),
                              child: Container(
                                  height:
                                      devicesize.screenHeight(context) * 0.0591,
                                  width: devicesize.screenWidth(context) * 0.37,
                                  decoration: BoxDecoration(
                                      color: custcolor.almostWhite,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 35, top: 10),
                                    child: Text(
                                      "Publicar",
                                      style: TextStyle(
                                        fontSize:
                                            devicesize.screenHeight(context) *
                                                0.027,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Raleway',
                                        color: custcolor.almostBlack,
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ), // el otro
                quickStrikeForm ? QuickStrikeCreation() : PostCreation(),
              ],
            )));
  }
}
