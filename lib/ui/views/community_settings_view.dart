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
  String rulesPlaceholder;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunitySettingsViewModel>.reactive(
      viewModelBuilder: () => CommunitySettingsViewModel(),
      onModelReady: (model) async {
        model
            .getData(widget.community.uid)
            .then((value) => rulesPlaceholder = model.rules)
            .then((value) => rulesController.text = rulesPlaceholder);
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
                              "Configuración",
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Posts públicos",
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
                                        ? Icon(Icons.check, color: almostBlack)
                                        : Container()),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight(context) * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Marketplace",
                                style: optionsStyle,
                              ),
                              GestureDetector(
                                onTap: () => setState(() {
                                  model.isMarketplace = !model.isMarketplace;
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
                                        ? Icon(Icons.check, color: almostBlack)
                                        : Container()),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              " Normas comunidad",
                              style: optionsStyle,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.03),
                              child: Container(
                                height: screenHeight(context) * 0.4,
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
                                      color: almostWhite,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.04),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    model.saveChanges(
                                        rulesController.text,
                                        model.isMarketplace,
                                        model.isPublic,
                                        widget.community.uid);

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
                                        child: Text("Guardar",
                                            style: optionsStyle)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
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
