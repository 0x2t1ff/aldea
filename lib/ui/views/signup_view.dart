import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';

import '../shared/ui_helpers.dart';
import '../widgets/busy_button.dart';
import '../widgets/input_field.dart';
import '../widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/signup_view_model.dart';

class SignUpView extends StatefulWidget {
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    EdgeInsets paddingFields =
        EdgeInsets.only(top: screenHeight(context) * 0.04);
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: blueishGreyColor,
        //hacer boxconstraints de max altura y meter singlechilds croll view para el texto 
        body: Container(
                  child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NotchFiller(),
                Container(
                    width: screenWidth(context),
                    height: screenHeight(context) * 0.12,
                    color: loginColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth(context) * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "ALDEA",
                            style: TextStyle(
                                color: almostWhite,
                                fontFamily: "Thinoo",
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth(context) * 0.1),
                          ),
                          SizedBox(
                              width: screenWidth(context) * 0.1,
                              child: Image.asset("assets/images/hoguera.png")),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.11),
                  child: Column(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: screenHeight(context) * 0.05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context) * 0.02),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: screenHeight(context) * 0.008),
                              child: Text(
                                "Nombre Completo",
                                style: TextStyle(
                                    color: blueTheme,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth(context) * 0.04),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: loginColor,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.02),
                              child: TextFormField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      bottom: screenHeight(context) * 0.015,
                                      left: screenWidth(context) * 0.03),
                                  hintText: "Example: aldea@aldea.es...",
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey[300],
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    color: almostWhite,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: paddingFields,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context) * 0.02),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: screenHeight(context) * 0.008),
                              child: Text(
                                "Email",
                                style: TextStyle(
                                    color: blueTheme,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth(context) * 0.04),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: loginColor,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.02),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      bottom: screenHeight(context) * 0.015,
                                      left: screenWidth(context) * 0.03),
                                  hintText: "Example: aldea@aldea.es...",
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey[300],
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    color: almostWhite,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: paddingFields,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context) * 0.02),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: screenHeight(context) * 0.008),
                              child: Text(
                                "Teléfono Movil",
                                style: TextStyle(
                                    color: blueTheme,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth(context) * 0.04),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: loginColor,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.02),
                              child: TextFormField(
                                controller: phoneController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      bottom: screenHeight(context) * 0.015,
                                      left: screenWidth(context) * 0.03),
                                  hintText: "Example: aldea@aldea.es...",
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey[300],
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    color: almostWhite,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: paddingFields,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context) * 0.02),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: screenHeight(context) * 0.008),
                              child: Text(
                                "Password",
                                style: TextStyle(
                                    color: blueTheme,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth(context) * 0.04),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: loginColor,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.02),
                              child: TextFormField(
                                obscureText: obscured,
                                controller: passwordController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      bottom: screenHeight(context) * 0.015,
                                      left: screenWidth(context) * 0.03),
                                  hintText: "Example: aldea@aldea.es...",
                                  hintStyle: TextStyle(
                                      color: Colors.blueGrey[300],
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    color: almostWhite,
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.02,
                            ),
                            child: GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Ver Contenido",
                                      style: TextStyle(
                                          fontFamily: 'Raleway',
                                          fontStyle: FontStyle.italic,
                                          color: almostWhite,
                                          fontSize:
                                              screenHeight(context) * 0.015),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth(context) * 0.02),
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: screenWidth(context) * 0.04,
                                          height: screenWidth(context) * 0.04,
                                          decoration: BoxDecoration(
                                            color: grey,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(3),
                                            ),
                                          ),
                                          child: obscured
                                              ? Container()
                                              : Icon(
                                                  Icons.check,
                                                  size: 18,
                                                )),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  setState(() {
                                    obscured = !obscured;
                                  });
                                }),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.08),
                              child: GestureDetector(
                                child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 3,
                                            offset: Offset(0,
                                                5), // changes position of shadow
                                          ),
                                        ],
                                        color: almostWhite,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(200))),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth(context) * 0.06,
                                          vertical: screenWidth(context) * 0.025),
                                      child: Text("Entrar",
                                          style: TextStyle(
                                              color: blueTheme,
                                              fontFamily: "Raleway",
                                              fontWeight: FontWeight.w600,
                                              fontSize:
                                                  screenWidth(context) * 0.04)),
                                    )),
                                onTap: () {
                                  model.signUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ]),
        ),
      ),
    );
  }
}
