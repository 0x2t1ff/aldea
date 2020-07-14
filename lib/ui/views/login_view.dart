import '../shared/ui_helpers.dart';
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
        resizeToAvoidBottomPadding: true,
        backgroundColor: loginColor,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: screenHeight(context),
                maxWidth: screenWidth(context)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: screenHeight(context) * 0.163),
                  child: Container(
                      child: Column(
                    children: <Widget>[
                      SizedBox(
                          height: screenHeight(context) * 0.2,
                          child: Image.asset("assets/images/hoguera.png")),
                      Padding(
                        padding:
                            EdgeInsets.only(top: screenHeight(context) * 0.08),
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
                        padding:
                            EdgeInsets.only(top: screenHeight(context) * 0.03),
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
                                        bottom: screenHeight(context) * 0.009),
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                          color: blueTheme,
                                          fontFamily: "Raleway",
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              screenWidth(context) * 0.04),
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
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: Offset(3, 3),
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth(context) * 0.03,
                                        top: screenHeight(context) * 0.02),
                                    child: TextFormField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            bottom:
                                                screenHeight(context) * 0.015,
                                            left: screenWidth(context) * 0.03),
                                        hintText: "Example: aldea@aldea.es...",
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.16),
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
                                )
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
                                          bottom:
                                              screenHeight(context) * 0.008),
                                      child: Text(
                                        "Password",
                                        style: TextStyle(
                                            color: blueTheme,
                                            fontFamily: "Raleway",
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                screenWidth(context) * 0.04),
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
                                          offset: Offset(0,
                                              5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: screenWidth(context) * 0.03,
                                              top:
                                                  screenHeight(context) * 0.02),
                                          child: TextFormField(
                                            obscureText: obscured,
                                            controller: passwordController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom:
                                                      screenHeight(context) *
                                                          0.015,
                                                  left: screenWidth(context) *
                                                      0.03),
                                              hintText: "*******",
                                              hintStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.16),
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
                                        Positioned(
                                          top: screenHeight(context) * 0.025,
                                          right: screenWidth(context) * 0.05,
                                          child: obscured
                                              ? GestureDetector(
                                                  child: Icon(
                                                    Icons.visibility_off,
                                                    size: 30,
                                                    color: blueishGreyColor,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      obscured = !obscured;
                                                    });
                                                  })
                                              : GestureDetector(
                                                  child: Icon(
                                                    Icons.visibility,
                                                    size: 30,
                                                    color: blueishGreyColor,
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      obscured = !obscured;
                                                    });
                                                  }),
                                        )
                                      ],
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
                                        fontSize:
                                            screenHeight(context) * 0.015),
                                  ),
                                  onTap: () {
                                    model.navigateRegister();
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.05),
                              child: GestureDetector(
                                child: Container(
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                          horizontal:
                                              screenWidth(context) * 0.06,
                                          vertical:
                                              screenWidth(context) * 0.025),
                                      child: Text("Entrar",
                                          style: TextStyle(
                                              color: blueTheme,
                                              fontFamily: "Raleway",
                                              fontWeight: FontWeight.w700,
                                              fontSize: screenWidth(context) *
                                                  0.045)),
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
        ),
      ),
    );
  }
}
