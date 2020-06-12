import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart' as device;
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/community_creation_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CommunityCreationView extends StatefulWidget {
  @override
  _CommunityCreationViewState createState() => _CommunityCreationViewState();
}

class _CommunityCreationViewState extends State<CommunityCreationView> {
  bool isAccepted;
  final TextStyle optionsStyle =
      TextStyle(fontFamily: 'Raleway', fontSize: 22, color: almostWhite);

  final solicitudController = TextEditingController();

  final nombreController = TextEditingController();

  final descripcionController = TextEditingController();

  final reglasController = TextEditingController();
  @override
  void initState() {
    isAccepted = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityCreationViewModel>.reactive(
      viewModelBuilder: () => CommunityCreationViewModel(),
      onModelReady: (model) => "",
      createNewModelOnInsert: true,
      builder: (context, model, child) => Scaffold(
        backgroundColor: darkGrey,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: <Widget>[
            NotchFiller(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              height: device.usableScreenHeight(context) * 0.1,
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
              height: device.screenHeight(context) * 0.84,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          width: device.screenWidth(context),
                          color: darkGrey,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: device.screenWidth(context) * 0.1),
                            width: device.screenWidth(context),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: device.screenHeight(context) * 0.02,
                                    bottom: device.screenHeight(context) * 0.02,
                                  ),
                                  child: Text(
                                    "Creación de comunidad",
                                    style: TextStyle(
                                        color: almostWhite,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25),
                                  ),
                                ),
                                Container(
                                    height: 2,
                                    width: device.screenWidth(context) * 0.8,
                                    color: almostWhite),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                          device.screenHeight(context) * 0.026),
                                  child: Container(
                                    width: device.screenWidth(context) * 0.8,
                                    height: device.screenHeight(context) * 0.21,
                                    decoration: model.bkdPic != null
                                        ? BoxDecoration(
                                            color: blueTheme,
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: FileImage(model.bkdPic)),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)))
                                        : BoxDecoration(
                                            color: blueTheme,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              device.screenWidth(context) * 0.8,
                                          height: device.screenHeight(context) *
                                              0.21,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                        ),
                                        Positioned(
                                          top: device.screenHeight(context) *
                                              0.04,
                                          right: device.screenWidth(context) *
                                              0.31,
                                          child: GestureDetector(
                                            onTap: () {
                                              model.selectProfileImage();
                                            },
                                            child: Container(
                                              width:
                                                  device.screenWidth(context) *
                                                      0.185,
                                              height:
                                                  device.screenWidth(context) *
                                                      0.185,
                                              decoration: model.profilePic !=
                                                      null
                                                  ? BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.contain,
                                                          image: FileImage(model
                                                              .profilePic)),
                                                      border: Border.all(
                                                          color: almostBlack,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(80),
                                                      ),
                                                    )
                                                  : BoxDecoration(
                                                      border: Border.all(
                                                          color: almostBlack,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(80),
                                                      ),
                                                    ),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          width:
                                              device.screenWidth(context) * 0.1,
                                          height:
                                              device.screenWidth(context) * 0.1,
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
                                      top:
                                          device.screenHeight(context) * 0.016),
                                  child: Text(
                                    "Nombre",
                                    style: optionsStyle,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: device.screenHeight(context) * 0.01),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight:
                                          device.screenHeight(context) * 0.043,
                                    ),
                                    child: Container(
                                      width: device.screenWidth(context) * 0.8,
                                      decoration: BoxDecoration(
                                        color: greyColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30),
                                        ),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        controller: nombreController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              top:
                                                  device.screenHeight(context) *
                                                      0.01,
                                              left:
                                                  device.screenHeight(context) *
                                                      0.01,
                                              bottom:
                                                  device.screenHeight(context) *
                                                      0.02),
                                          filled: false,
                                          enabledBorder: InputBorder.none,
                                        ),
                                        style: TextStyle(
                                            color: almostWhite,
                                            fontFamily: "Raleway",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                          device.screenHeight(context) * 0.025),
                                  child: Text(
                                    "Descripción",
                                    style: optionsStyle,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: device.screenHeight(context) * 0.01),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight:
                                          device.screenHeight(context) * 0.1,
                                    ),
                                    child: Container(
                                      width: device.screenWidth(context) * 0.8,
                                      decoration: BoxDecoration(
                                        color: greyColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        controller: descripcionController,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: device
                                                        .screenHeight(context) *
                                                    0.01,
                                                left: device
                                                        .screenHeight(context) *
                                                    0.01,
                                                bottom: device
                                                        .screenHeight(context) *
                                                    0.01),
                                            filled: false,
                                            enabledBorder: InputBorder.none,
                                            border: InputBorder.none),
                                        style: TextStyle(
                                            color: almostWhite,
                                            fontFamily: "Raleway",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                          device.screenHeight(context) * 0.025),
                                  child: Text("Reglas de comunidad",
                                      style: optionsStyle),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: device.screenHeight(context) * 0.01),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                        minHeight:
                                            device.screenHeight(context) * 0.1),
                                    child: Container(
                                      width: device.screenWidth(context) * 0.8,
                                      decoration: BoxDecoration(
                                        color: greyColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        controller: reglasController,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: device
                                                        .screenHeight(context) *
                                                    0.01,
                                                left: device
                                                        .screenHeight(context) *
                                                    0.01,
                                                bottom: device
                                                        .screenHeight(context) *
                                                    0.01),
                                            filled: false,
                                            enabledBorder: InputBorder.none,
                                            border: InputBorder.none),
                                        style: TextStyle(
                                            color: almostWhite,
                                            fontFamily: "Raleway",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                          device.screenHeight(context) * 0.025),
                                  child: Text(
                                    "Solicitud",
                                    style: optionsStyle,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: device.screenHeight(context) * 0.01),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight:
                                          device.screenHeight(context) * 0.1,
                                    ),
                                    child: Container(
                                      width: device.screenWidth(context) * 0.8,
                                      decoration: BoxDecoration(
                                        color: greyColor,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        controller: solicitudController,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                top: device
                                                        .screenHeight(context) *
                                                    0.01,
                                                left: device
                                                        .screenHeight(context) *
                                                    0.01,
                                                bottom: device
                                                        .screenHeight(context) *
                                                    0.01),
                                            filled: false,
                                            enabledBorder: InputBorder.none,
                                            border: InputBorder.none),
                                        style: TextStyle(
                                            color: almostWhite,
                                            fontFamily: "Raleway",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top:
                                          device.screenHeight(context) * 0.028),
                                  child: Text("Términos y condiciones",
                                      style: optionsStyle),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: device.screenHeight(context) * 0.018,
                                  ),
                                  child: Text(
                                    "El supuesto sujeto con la intención de crear una comunidad en Aldea se compromete y se hacer cargo total de todo lo que pueda ejercer que vaya en contra de cualquier ley o norma registrada en el país de realización del mismo. Así cualquier venta o sugerimiento realizado a través de su propio perfil o incluso incumplimiento por mala gestión de comunidad, caerá a cargo suyo librando de cualquier inconveniente a los admins de la aplicación Aldea.",
                                    style: TextStyle(
                                      color: grey,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: device.screenWidth(context) *
                                              0.018,
                                          top: device.screenHeight(context) *
                                              0.014),
                                      child: GestureDetector(
                                        onTap: () => setState(() {
                                          isAccepted = !isAccepted;
                                        }),
                                        child: Container(
                                            width: device.screenWidth(context) *
                                                0.066,
                                            height:
                                                device.screenHeight(context) *
                                                    0.03,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: grey,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(6))),
                                            child: isAccepted
                                                ? Icon(Icons.check,
                                                    color: almostBlack)
                                                : Container()),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: device.screenHeight(context) *
                                              0.02),
                                      child: Container(
                                        width:
                                            device.screenWidth(context) * 0.7,
                                        child: Text(
                                          "Acepto hacer y haber leído los términos y condiciones",
                                          style: TextStyle(
                                            color: blueTheme,
                                            fontFamily: 'Raleway',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: device.screenWidth(context) * 0.155,
                                      top: device.screenHeight(context) * 0.03,
                                      bottom:
                                          device.screenHeight(context) * 0.03),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (model.bkdPic == null ||
                                          model.profilePic == null ||
                                          solicitudController.text == null ||
                                          nombreController.text == null ||
                                          descripcionController.text == null ||
                                          reglasController.text == null) {
                                        model.fieldsDialog();
                                      } else {
                                        if (isAccepted) {
                                          model.createRequest(
                                              model.currentUser,
                                              solicitudController.text,
                                              nombreController.text,
                                              reglasController.text,
                                              descripcionController.text);
                                              model.backToSettings();
                                        } else {
                                          model.termsDialog();
                                        }
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: device.screenWidth(context) * 0.48,
                                      height:
                                          device.screenHeight(context) * 0.05,
                                      decoration: BoxDecoration(
                                        color: blueTheme,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(200),
                                        ),
                                      ),
                                      child: Text(
                                        "¡Enviar petición!",
                                        style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w600,
                                            color: almostWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
