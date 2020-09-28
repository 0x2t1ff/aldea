import 'package:aldea/constants/languages.dart';
import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/community_settings_view_model.dart';
import "../shared/ui_helpers.dart";
import "../shared/shared_styles.dart";

class CommunitySettingsView extends StatefulWidget {
  final Community community;
  const CommunitySettingsView(
    this.community,
  );

  @override
  _CommunitySettingsViewState createState() => _CommunitySettingsViewState();
}

class _CommunitySettingsViewState extends State<CommunitySettingsView> {
  final TextStyle optionsStyle =
      TextStyle(fontFamily: 'Raleway', fontSize: 22, color: almostWhite);
  final rulesController = TextEditingController();
  final descriptionController = TextEditingController();
  String rulesPlaceholder;
  String description;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunitySettingsViewModel>.reactive(
      viewModelBuilder: () => CommunitySettingsViewModel(),
      onModelReady: (model) async {
        model.getData(widget.community.uid).then((value) {
          rulesController.text = model.rules;
          descriptionController.text = model.description;
        });
      },
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: darkGrey,
        body: !model.busy
            ? Column(
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
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth(context) * 0.1),
                    child: Container(
                      height: screenHeight(context) * 0.8385 -
                          MediaQuery.of(context).viewInsets.bottom,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight(context) * 0.02,
                                bottom: screenHeight(context) * 0.02,
                              ),
                              child: Center(
                                child: Text(
                                  languages[model.currentLanguage]["config"],
                                  style: TextStyle(
                                      color: almostWhite,
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25),
                                ),
                              ),
                            ),
                            Container(
                                height: 2,
                                width: screenWidth(context) * 0.8,
                                color: almostWhite),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.03),
                              child: Container(
                                width: screenWidth(context) * 0.8,
                                height: screenHeight(context) * 0.21,
                                decoration: model.bkdPic != null
                                    ? BoxDecoration(
                                        color: blueTheme,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(model.bkdPic)),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)))
                                    : BoxDecoration(
                                        color: blueTheme,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              widget.community.bkdPicUrl),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                child: Stack(
                                  children: <Widget>[
                                    Container(
                                      width: screenWidth(context) * 0.8,
                                      height: screenHeight(context) * 0.21,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                    ),
                                    Positioned(
                                      top: screenHeight(context) * 0.04,
                                      right: screenWidth(context) * 0.31,
                                      child: GestureDetector(
                                        onTap: () {
                                          model.selectProfileImage();
                                        },
                                        child: Container(
                                          width: screenWidth(context) * 0.185,
                                          height: screenWidth(context) * 0.185,
                                          decoration: model.profilePic != null
                                              ? BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: FileImage(
                                                          model.profilePic)),
                                                  border: Border.all(
                                                      color: almostBlack,
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(80),
                                                  ),
                                                )
                                              : BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                        widget.community
                                                            .iconPicUrl,
                                                      ),
                                                      fit: BoxFit.cover),
                                                  border: Border.all(
                                                      color: almostBlack,
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(80),
                                                  ),
                                                ),
                                          child: Icon(Icons.add,
                                              color: blueTheme, size: 30),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: screenHeight(context) * 0.04,
                                      right: screenWidth(context) * 0.31,
                                      child: Container(
                                        width: screenWidth(context) * 0.185,
                                        height: screenWidth(context) * 0.185,
                                        decoration: BoxDecoration(
                                          color: model.profilePic != null
                                              ? Colors.black.withOpacity(0)
                                              : Colors.black.withOpacity(0.4),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(80),
                                          ),
                                        ),
                                        child: Icon(Icons.add,
                                            color: Colors.white, size: 30),
                                      ),
                                    ),
                                    Positioned(
                                      width: screenWidth(context) * 0.1,
                                      height: screenWidth(context) * 0.1,
                                      child: GestureDetector(
                                        onTap: () => model.selectBkdImage(),
                                        child: Icon(
                                          Icons.add,
                                          color: almostWhite,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.03),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    languages[model.currentLanguage]
                                        ["public posts"],
                                    style: optionsStyle,
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      model.isPublic = !model.isPublic;
                                    }),
                                    child: Container(
                                        width: screenWidth(context) * 0.066,
                                        height: screenHeight(context) * 0.03,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        child: model.isPublic
                                            ? Icon(Icons.check,
                                                color: almostBlack)
                                            : Container()),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenHeight(context) * 0.03),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    languages[model.currentLanguage]
                                        ["marketplace"],
                                    style: optionsStyle,
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(() {
                                      model.isMarketplace =
                                          !model.isMarketplace;
                                    }),
                                    child: Container(
                                        width: screenWidth(context) * 0.066,
                                        height: screenHeight(context) * 0.03,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: grey,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6))),
                                        child: model.isMarketplace
                                            ? Icon(Icons.check,
                                                color: almostBlack)
                                            : Container()),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              languages[model.currentLanguage]["desc"],
                              style: optionsStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.02),
                              child: Container(
                                height: screenHeight(context) * 0.15,
                                width: screenWidth(context) * 0.8,
                                decoration: BoxDecoration(
                                  color: Color(0xff17191E),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: TextFormField(
                                  maxLength: 80,
                                  buildCounter: (BuildContext context,
                                      {int currentLength,
                                      int maxLength,
                                      bool isFocused}) {
                                    return isFocused
                                        ? Text(
                                            ' $currentLength/$maxLength ',
                                            style: new TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 10,
                                                color: blueTheme),
                                            semanticsLabel: 'Input constraints',
                                          )
                                        : null;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: descriptionController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: screenHeight(context) * 0.04,
                                          left: screenHeight(context) * 0.04,
                                          right: screenHeight(context) * 0.04,
                                          bottom: screenHeight(context) * 0.01),
                                      filled: false,
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: grey,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.03),
                              child: Text(
                                languages[model.currentLanguage]
                                    ["community rules"],
                                style: optionsStyle,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                top: screenHeight(context) * 0.02,
                              ),
                              child: Container(
                                height: screenHeight(context) * 0.20,
                                width: screenWidth(context) * 0.8,
                                decoration: BoxDecoration(
                                  color: Color(0xff17191E),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: rulesController,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: screenHeight(context) * 0.04,
                                          left: screenHeight(context) * 0.04,
                                          right: screenHeight(context) * 0.04,
                                          bottom: screenHeight(context) * 0.01),
                                      filled: false,
                                      enabledBorder: InputBorder.none,
                                      border: InputBorder.none),
                                  style: TextStyle(
                                      color: grey,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.04,
                                  bottom: screenHeight(context) * 0.04),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    model.saveChanges(
                                        rulesController.text,
                                        model.isMarketplace,
                                        model.isPublic,
                                        widget.community.uid,
                                        descriptionController.text);

                                    model.popWindow();
                                  },
                                  child: Container(
                                    width: screenWidth(context) * 0.3,
                                    height: screenWidth(context) * 0.1,
                                    decoration: BoxDecoration(
                                      color: blueTheme,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(300),
                                      ),
                                    ),
                                    child: Center(
                                        child: Text(
                                            languages[model.currentLanguage]
                                                ["save"],
                                            style: optionsStyle)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(blueishGreyColor),
                ),
              ),
      ),
    );
  }
}
