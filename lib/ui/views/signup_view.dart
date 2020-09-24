import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:international_phone_input/international_phone_input.dart';
import '../shared/ui_helpers.dart';
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
        resizeToAvoidBottomInset: true,
        backgroundColor: blueishGreyColor,
        //hacer boxconstraints de max altura y meter singlechilds croll view para el texto
        body: SingleChildScrollView(
          child: Container(
            height: screenHeight(context) +
                notchHeight(context) +
                bottomHeight(context),
            width: screenWidth(context),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NotchFiller(),
                  Container(
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
                                child:
                                    Image.asset("assets/images/hoguera.png")),
                          ],
                        ),
                      )),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context) * 0.11),
                          child: Column(children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight(context) * 0.05),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth(context) * 0.02),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          bottom: screenHeight(context) * 0.01),
                                      child: Text(
                                        "Nombre Completo",
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
                                          //bottom: screenHeight(context) * 0.015,
                                          top: screenHeight(context) * 0.02),
                                      child: TextFormField(
                                        controller: nameController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              bottom:
                                                  screenHeight(context) * 0.015,
                                              left:
                                                  screenWidth(context) * 0.03),
                                          hintText: " Juan Garcia...",
                                          hintStyle: TextStyle(
                                              color: Colors.white
                                                  .withOpacity(0.16),
                                              fontFamily: "Raleway",
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 14),
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
                                          bottom:
                                              screenHeight(context) * 0.008),
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
                                              left:
                                                  screenWidth(context) * 0.03),
                                          hintText:
                                              "Example: aldea@aldea.es...",
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
                                          bottom:
                                              screenHeight(context) * 0.008),
                                      child: Text(
                                        "Teléfono Movil",
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
                                      ),
                                      child: InternationalPhoneInput(
                                        decoration: InputDecoration(
                                          fillColor: loginColor,
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Colors.transparent),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Colors.transparent),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                width: 0,
                                                color: Colors.transparent),
                                          ),
                                        ),
                                        enabledCountries: ["ES"],
                                        showCountryCodes: false,
                                        onPhoneNumberChange: (phone,
                                                internationalPhone, isoCode) =>
                                            model.onPhoneNumberChange(
                                                internationalPhone),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: paddingFields,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: screenHeight(context) * 0.065),
                                      child: GestureDetector(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.5),
                                                    spreadRadius: 0,
                                                    blurRadius: 3,
                                                    offset: Offset(3, 3),
                                                  ),
                                                ],
                                                color: almostWhite,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(200))),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenWidth(context) *
                                                          0.06,
                                                  vertical:
                                                      screenWidth(context) *
                                                          0.025),
                                              child: Text("Entrar",
                                                  style: TextStyle(
                                                      color: blueTheme,
                                                      fontFamily: "Raleway",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize:
                                                          screenWidth(context) *
                                                              0.045)),
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
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
