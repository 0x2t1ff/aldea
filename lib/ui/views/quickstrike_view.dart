import 'dart:math';
import 'dart:ui';

import 'package:aldea/constants/languages.dart';
import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/quickstrike_item.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import "package:flutter/material.dart";
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

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuickStrikeViewModel>.reactive(
        viewModelBuilder: () => QuickStrikeViewModel(),
        onModelReady: (model) async => await model.fetchPosts(),
        createNewModelOnInsert: true,
        builder: (context, model, child) => WillPopScope(
              onWillPop: model.onWillPop,
              child: Scaffold(
                  backgroundColor: custcolor.blueishGreyColor,
                  body: model.busy || model.posts == null
                      ? Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                custcolor.blueishGreyColor),
                          ),
                        )
                      : Stack(
                          children: [
                            Container(
                              child: Stack(children: <Widget>[
                                ListView.builder(
                                    padding: EdgeInsets.all(0),
                                    itemCount: model.posts.length >= 8
                                        ? model.posts.length
                                        : 8,
                                    itemBuilder: (context, index) {
                                      if (model.posts.length > index) {
                                        return QuickStrikeItem(
                                            heroFunction: () =>
                                                model.heroAnimation(model
                                                    .posts[index].imageUrl),
                                            isParticipating:
                                                model.participatingIds.contains(
                                                    model.posts[index].id),
                                            model: model,
                                            quickStrikePost: model.posts[index],
                                            index: index);
                                      } else {
                                        return QuickStrikeItem(
                                          isParticipating: false,
                                          index: index,
                                          quickStrikePost: emptyQuickstrike,
                                          model: model,
                                        );
                                      }
                                    }),
                                model.quickstrikeActive
                                    ? getQuickstrike(
                                        model.activeQuickstrike, model)
                                    : Container(),
                              ]),
                            ),
                            model.showEmptyDialog
                                ? Align(
                                    child: Container(
                                        width: screenWidth(context) * 0.65,
                                        height: screenWidth(context) * 0.6,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: custcolor.darkGrey
                                                    .withOpacity(1),
                                                spreadRadius: 2,
                                                blurRadius: 1,
                                                offset: Offset(3,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                            color: custcolor.blueTheme,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              right: screenWidth(context) * 0.1,
                                              top:
                                                  screenHeight(context) * 0.035,
                                              left: screenWidth(context) * 0.1),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                languages[model.currentLanguage]
                                                    ["oops"],
                                                style: TextStyle(
                                                    color:
                                                        custcolor.almostWhite,
                                                    fontFamily: "Raleway",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  top: screenHeight(context) *
                                                      0.02,
                                                ),
                                                child: Container(
                                                  color: custcolor.almostWhite,
                                                  width: double.infinity,
                                                  height: 3,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top: screenHeight(context) *
                                                        0.02,
                                                    bottom:
                                                        screenHeight(context) *
                                                            0.02),
                                                child: Text(
                                                    languages[model
                                                            .currentLanguage]
                                                        ["quickstrikes empty"],
                                                    style: TextStyle(
                                                      color:
                                                          custcolor.almostBlack,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                : Container()
                          ],
                        )),
            ));
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
              model.finishQuickstrike();
              model.submitResult(model.activeQuickstrike.id);
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
      model.activeQuickstrike.wrongAnswers.length == 3
          ? padding = 0.02
          : padding = 0.02;
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
                                  model.activeQuickstrike.question,
                                  maxLines: 3,
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
                            itemCount: model.randomQuestions.length,
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
                                        model.randomQuestions[index],
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
                                    if (model.randomQuestions[index] ==
                                        model.activeQuickstrike.correctAnswer) {
                                      print("yeeted son");
                                      model.submitResult(quickstrike.id);
                                      model.finishQuickstrike();
                                    } else {
                                      model.quitQuickstrike(quickstrike);
                                      model.failedQuickstrike();
                                      model.finishQuickstrike();
                                    }
                                  });
                            }))
                  ],
                )),
          ),
        ),
      ));
    } else {
      return Container();
    }
  }
}
