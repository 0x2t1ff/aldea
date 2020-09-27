import 'package:aldea/models/user_model.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/language_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import "../shared/ui_helpers.dart";

class LanguageView extends StatelessWidget {
  LanguageView();

  final TextStyle optionsStyle =
      TextStyle(fontFamily: 'Raleway', fontSize: 22, color: almostWhite);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LanguageViewModel>.reactive(
        viewModelBuilder: () => LanguageViewModel(),
        onModelReady: (model) {
          model.getLanguage();
        },
        builder: (context, model, child) => Scaffold(
              backgroundColor: darkGrey,
              body: Stack(children: <Widget>[
                Column(
                  children: <Widget>[
                    NotchFiller(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      width: double.infinity,
                      height: screenHeight(context) * 0.1,
                      alignment: Alignment.centerLeft,
                      color: Color(0xff17191E),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'ALDEA',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Thinoo',
                                fontSize: 40),
                          ),
                          SizedBox(
                            height: 50,
                            child: Image.asset('assets/images/hoguera.png'),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: screenHeight(context) * 0.01),
                      child: GestureDetector(
                          onTap: () => model.changeLanguage("English"),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              color: backgroundColor,
                              width: screenWidth(context),
                              height: screenHeight(context) * 0.11,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth(context) * 0.05),
                                    child: Text(
                                      "English",
                                      style: TextStyle(
                                          color: almostWhite,
                                          fontFamily: "Raleway",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                  model.selectedLanguage.compareTo("English") ==
                                          0
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              right:
                                                  screenWidth(context) * 0.1),
                                          child: Container(
                                            width: screenWidth(context) * 0.07,
                                            height: screenWidth(context) * 0.07,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.black),
                                              shape: BoxShape.circle,
                                              color: blueTheme,
                                            ),
                                            child: Icon(
                                              Icons.check,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      : Container()
                                ],
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              ))),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: screenHeight(context) * 0.01),
                      child: GestureDetector(
                        onTap: () => model.changeLanguage("Español"),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            color: backgroundColor,
                            width: screenWidth(context),
                            height: screenHeight(context) * 0.11,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth(context) * 0.05),
                                  child: Text(
                                    "Español",
                                    style: TextStyle(
                                        color: almostWhite,
                                        fontFamily: "Raleway",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ),
                                model.selectedLanguage.compareTo("Español") == 0
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                            right: screenWidth(context) * 0.1),
                                        child: Container(
                                          width: screenWidth(context) * 0.07,
                                          height: screenWidth(context) * 0.7,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2, color: Colors.black),
                                            shape: BoxShape.circle,
                                            color: blueTheme,
                                          ),
                                          child: Icon(
                                            Icons.check,
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            )),
                      ),
                    )
                  ],
                ),
                Positioned(
                    left: screenWidth(context) * 0.325,
                    bottom: screenHeight(context) * 0.08,
                    child: GestureDetector(
                      onTap: () =>
                          model.changeUserLanguage(model.selectedLanguage),
                      child: Container(
                          alignment: Alignment.center,
                          width: screenWidth(context) * 0.35,
                          height: screenHeight(context) * 0.07,
                          decoration: BoxDecoration(
                              color: blueTheme,
                              borderRadius: BorderRadius.circular(40)),
                          child: Text(
                            "Aceptar",
                            style: TextStyle(
                              color: almostWhite,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                            fontSize: 20),
                          )),
                    ))
              ]),
            ));
  }
}
