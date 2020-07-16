import 'dart:math';
import 'dart:ui';

import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/quickstrike_item.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import "../shared/app_colors.dart" as custcolor;

class QuickSTrikeView extends StatefulWidget {
  @override
  _QuickSTrikeViewState createState() => _QuickSTrikeViewState();
}

class _QuickSTrikeViewState extends State<QuickSTrikeView> {
  final QuickStrikePost emptyQuickstrike = new QuickStrikePost(
    isEmpty: true,
  );

  static double getRandomWidth() {
    final _random = new Random();
    double randomNumber = _random.nextDouble();
    randomNumber = randomNumber * 0.8;
    return randomNumber.toDouble();
  }

  static double getRandomHeight() {
    final _random = new Random();
    double randomNumber = _random.nextDouble();
    randomNumber = randomNumber * 0.66;
    return randomNumber.toDouble();
  }

  final double buttonWidth = getRandomWidth();
  final double buttonHeight = getRandomHeight();
  List testingData = [" 123 ", "e489763", "dksbgja", "fribak"];
  int answer = 2;

  bool quickstrikeActive = false;
  QuickStrikePost activeQuickstrike;
  @override
  // if there was a necessity of modifying this piece of code I take all responibility since I don't even know what the fuck it is anymore
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuickStrikeViewModel>.reactive(
        viewModelBuilder: () => QuickStrikeViewModel(),
        onModelReady: (model) => model.fetchPosts(),
        createNewModelOnInsert: true,
        builder: (context, model, child) => Scaffold(
            body: !model.busy
                ? Container(
                    child: Stack(children: <Widget>[
                      StreamBuilder(
                        stream: model.posts,
                        builder: (context, data) {
                          if (data.hasData == false) {
                            return ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: 8,
                                itemBuilder: (context, index) {
                                  return QuickStrikeItem(
                                    isParticipating: false,
                                    index: index,
                                    quickStrikePost: emptyQuickstrike,
                                    model: model,
                                  );
                                });
                          } else if (data.hasError) {
                            return Text(data.error.toString());
                          } else if (data.data == null) {
                            return Center(child: Text("data is null"));
                          } else {
                            List dataList = data.data;
                            List<DocumentSnapshot> documentList = [];
                            List<QuickStrikePost> quickstrikepostList = [];
                            //Primer foreach para filtrar el stream , ya que pasa un valor que no es un documentsnapshot dentro de la lista
                            dataList.forEach((element) {
                              if (element.runtimeType == DocumentSnapshot) {
                                documentList.add(element);
                              }
                            });
                            documentList.forEach((element) {
                              DocumentSnapshot docSnapshot = element;
                              Map<dynamic, dynamic> quickstrikeMap =
                                  docSnapshot.data;
                              quickstrikepostList
                                  .add(QuickStrikePost.fromMap(quickstrikeMap));
                            });
                            return quickstrikepostList.length >= 8
                                ? ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: quickstrikepostList.length,
                                    itemBuilder: (context, index) {
                                      bool participating;
                                      //si el quickstrike esta activo comprueba que el usuario esta participando.
                                      if (quickstrikepostList[index].isActive &&
                                          quickstrikeActive == false) {
                                        model
                                            .checkParticipatingQuickstrike(
                                                quickstrikepostList[index].id)
                                            .then((value) {
                                          participating = value;
                                          if (value) {
                                            setState(() {
                                              quickstrikeActive = true;
                                              activeQuickstrike =
                                                  quickstrikepostList[index];
                                            });
                                          } else {}
                                        });
                                      }
                                      return QuickStrikeItem(
                                          heroFunction: () =>
                                              model.heroAnimation(
                                                  quickstrikepostList[index]
                                                      .imageUrl[0]),
                                          isParticipating: true,
                                          model: model,
                                          quickStrikePost:
                                              quickstrikepostList[index],
                                          index: index);
                                    })
                                : ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: 8,
                                    itemBuilder: (context, index) {
                                      if (quickstrikepostList.length > index) {
                                        if (quickstrikepostList[index]
                                                .isActive &&
                                            quickstrikeActive == false) {
                                          model
                                              .checkParticipatingQuickstrike(
                                                  quickstrikepostList[index].id)
                                              .then((value) {
                                            if (value == true) {
                                              setState(() {
                                                quickstrikeActive = true;
                                                activeQuickstrike =
                                                    quickstrikepostList[index];
                                              });
                                            } else {}
                                          });
                                        }

                                        return QuickStrikeItem(
                                            heroFunction: () =>
                                                model.heroAnimation(
                                                    quickstrikepostList[index]
                                                        .imageUrl),
                                            isParticipating: true,
                                            model: model,
                                            quickStrikePost:
                                                quickstrikepostList[index],
                                            index: index);
                                      } else {
                                        if (index == 7 &&
                                            quickstrikeActive == true) {}
                                        return QuickStrikeItem(
                                          isParticipating: false,
                                          index: index,
                                          quickStrikePost: emptyQuickstrike,
                                          model: model,
                                        );
                                      }
                                    });
                          }
                        },
                      ),
                      quickstrikeActive
                          ? getQuickstrike(activeQuickstrike, model)
                          : Container(),
                    ]),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                    ),
                  )));
  }

  Widget getQuickstrike(
      QuickStrikePost quickstrike, QuickStrikeViewModel model) {
    if (quickstrike.isGame) {
      return Padding(
        padding: EdgeInsets.only(
            top: screenHeight(context) * buttonHeight,
            left: screenWidth(context) * buttonWidth),
        child: Container(
          width: screenWidth(context) * 0.2,
          height: screenWidth(context) * 0.2,
          child: GestureDetector(
            onTap: () async {
              setState(() {
                quickstrikeActive = false;
              });
              model.submitResult(activeQuickstrike.id);
            },
            child: Container(
                child: Image.asset("assets/images/boton_quickstrike.png"),
                width: screenWidth(context) * 0.2,
                height: screenWidth(context) * 0.2),
          ),
        ),
      );
    } else if (quickstrike.isQuestion) {
// with 4 screenHeight(context) * 0.02
// with 3 screenHeight(context) * 0.05
      double padding;
      testingData.length == 3 ? padding = 0.05 : padding = 0.02;
      return Center(
          child: Container(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Container(
                decoration: BoxDecoration(
                  color: custcolor.almostWhite.withOpacity(0.1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                alignment: Alignment.center,
                width: screenWidth(context) * 0.85,
                height: screenHeight(context) * 0.7,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.only(top: screenHeight(context) * 0.05),
                      child: Container(
                        width: screenWidth(context) * 0.7,
                        height: screenHeight(context) * 0.22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                            color: custcolor.almostWhite),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenWidth(context) * 0.03),
                              child: Text("Quiz!",
                                  style: TextStyle(
                                      color: custcolor.almostBlack,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth(context) * 0.08)),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight(context) * 0.01),
                              child: Container(
                                height: 5,
                                width: screenWidth(context) * 0.55,
                                decoration: BoxDecoration(
                                  color: custcolor.almostBlack,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.002),
                              child: SizedBox(
                                width: screenWidth(context) * 0.55,
                                height: screenHeight(context) * 0.12,
                                child: AutoSizeText(
                                  quickstrike.description,
                                  maxLines: 3,
                                  //overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: custcolor.almostBlack,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth(context) * 0.055,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        width: screenWidth(context) * 0.7,
                        height: screenHeight(context) * 0.42,
                        child: ListView.builder(
                            padding: EdgeInsets.all(0),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: testingData.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight(context) * padding),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: screenWidth(context) * 0.6,
                                      height: screenHeight(context) * 0.08,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(300)),
                                          color: custcolor.blueTheme),
                                      child: Text(
                                        testingData[index],
                                        style: TextStyle(
                                            color: custcolor.almostBlack,
                                            fontFamily: "Raleway",
                                            fontWeight: FontWeight.bold,
                                            fontSize:
                                                screenWidth(context) * 0.05),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (index == answer) {
                                      print("yeeted son");
                                      model.submitResult(quickstrike.id);
                                    } else {
                                      model.quitQuickstrike(quickstrike);
                                      model.failedQuickstrike();
                                      quickstrikeActive = false;
                                      setState(() {});
                                    }
                                  });
                            }))
                  ],
                )),
          ),
        ),
      ));
    }
  }
}
