import '../shared/ui_helpers.dart';
import '../widgets/busy_button.dart';
import '../widgets/input_field.dart';
import '../widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/login_view_model.dart';
import "../shared/app_colors.dart";

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  bool obscured = true;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: loginColor,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: screenHeight(context) * 0.08),
              child: Container(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                      //height: screenHeight(context) * 0.2,
                      height: screenHeight(context) * 0.0,
                      child: Image.asset("assets/images/hoguera.png")),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight(context) * 0.08),
                    child: Text(
                      "ALDEA",
                      style: TextStyle(
                          color: almostWhite,
                          fontWeight: FontWeight.bold,
                          fontFamily: "thinoo",
                          fontSize: screenWidth(context) * 0.1),
                    ),
                  )
                ],
              )),
            ),
            Container(
                width: screenWidth(context),
                height: screenHeight(context) * 0.5,
                decoration: BoxDecoration(
                    color: blueishGreyColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context) * 0.12),
                  child: Padding(
                    padding: EdgeInsets.only(top: screenHeight(context) * 0.03),
                    child: Column(
                      children: <Widget>[
                        Column(
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                                    top: screenHeight(context) * 0.01),
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: screenHeight(context) * 0.04),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: screenHeight(context) * 0.01),
                                  child: TextFormField(
                                    obscureText: obscured,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              obscured = !obscured;
                                            });
                                          },
                                          child: obscured
                                              ? Icon(
                                                  Icons.visibility,
                                                )
                                              : Icon(Icons.visibility_off)),
                                      contentPadding: EdgeInsets.only(
                                          bottom: screenHeight(context) * 0.015,
                                          left: screenWidth(context) * 0.03),
                                      hintText: "Example: contraseña",
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight(context) * 0.02),
                            child: GestureDetector(
                              child: Text(
                                '¿Eres nuevo? Registrate.',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontStyle: FontStyle.italic,
                                    color: almostWhite,
                                    fontSize: screenHeight(context) * 0.015),
                              ),
                              onTap: () {
                                model.navigateRegister();
                              },
                            ),
                          ),
                        ),
                        Padding(
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
                                        offset: Offset(
                                            0, 5), // changes position of shadow
                                      ),
                                    ],
                                    color: almostWhite,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(200))),
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
                              model.login(
                                  email: emailController.text,
                                  password: passwordController.text);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
