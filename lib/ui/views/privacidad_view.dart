import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/ui/shared/app_colors.dart';

class PrivacidadView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      body: Column(
        children: [
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
                      color: Colors.white, fontFamily: 'Thinoo', fontSize: 40),
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
                EdgeInsets.symmetric(vertical: screenHeight(context) * 0.03),
            child: Text(
              "Terminos y condiciones",
              style: TextStyle(
                  color: almostWhite,
                  fontFamily: "Raleway",
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.131),
            child: Container(
              width: screenWidth(context),
              height: 3,
              color: almostWhite,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight(context) * 0.03),
            child: Text(
              "haha no da",
              style: TextStyle(
                color: almostWhite,
                fontFamily: "Raleway",
              ),
            ),
          )
        ],
      ),
    );
  }
}
