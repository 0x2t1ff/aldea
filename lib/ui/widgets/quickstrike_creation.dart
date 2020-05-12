import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import "../shared/ui_helpers.dart" as devicesize;
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import "package:aldea/constants/icondata.dart" as custicon;
import "../shared/app_colors.dart" as custcolor;

class QuickStrikeCreation extends StatefulWidget {
  @override
  _QuickStrikeCreationState createState() => _QuickStrikeCreationState();
}

class _QuickStrikeCreationState extends State<QuickStrikeCreation> {
  var time;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding:
              EdgeInsets.symmetric(vertical: devicesize.screenHeight(context) * 0.0221),
          child: Container(
            width: devicesize.screenWidth(context) * 0.682,
            height: 2,
            color: custcolor.almostWhite,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: devicesize.screenWidth(context) * 0.47),
          child: Text(" Opciones",
              style: TextStyle(
                  color: custcolor.almostWhite,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize:  devicesize.screenHeight(context) * 0.027)),
        ),
        Padding(
          padding: EdgeInsets.only(top: devicesize.screenHeight(context)* 0.02),
          child: Container(
            width: devicesize.screenWidth(context) * 0.694,
            height: devicesize.screenHeight(context) * 0.211,
            decoration: BoxDecoration(
              color: custcolor.almostBlack,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: devicesize.screenWidth(context) * 0.613,
                    height: devicesize.screenHeight(context) * 0.0296,
                    decoration: BoxDecoration(
                        color: custcolor.greyColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: devicesize.screenWidth(context) * 0.189,
                          height: devicesize.screenHeight(context) * 0.0296,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: custcolor.almostWhite,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            "Cantidad",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: devicesize.screenWidth(context) * 0.35),
                          child: Icon(
                            Icons.expand_more,
                            color: custcolor.almostWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: devicesize.screenWidth(context) * 0.2),
                      width: devicesize.screenWidth(context) * 0.613,
                      height: devicesize.screenHeight(context) * 0.0296,
                      decoration: BoxDecoration(
                        color: custcolor.greyColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          fillColor: custcolor.greyColor,
                        ),
                        style: new TextStyle(
                          fontFamily: "Raleway",
                        ),
                      ),
                    ),
                    Container(
                      width: devicesize.screenWidth(context) * 0.189,
                      height: devicesize.screenHeight(context) * 0.0296,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: custcolor.almostWhite,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        "Tipo",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: devicesize.screenWidth(context) * 0.2),
                      width: devicesize.screenWidth(context) * 0.613,
                      height: devicesize.screenHeight(context) * 0.0296,
                      decoration: BoxDecoration(
                        color: custcolor.greyColor,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          fillColor: custcolor.greyColor,
                        ),
                        style: new TextStyle(
                          fontFamily: "Raleway",
                        ),
                      ),
                    ),
                    Container(
                      width: devicesize.screenWidth(context) * 0.189,
                      height: devicesize.screenHeight(context) * 0.0296,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:custcolor.almostWhite,
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        "Modelo",
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            fontSize:
                                devicesize.screenHeight(context) * 0.0145),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    print("se ha pulsado");
                    DatePicker.showDateTimePicker(context,
                        theme: DatePickerTheme(
                            backgroundColor: Color(0xff3C8FA7),
                            itemStyle: TextStyle(
                                fontFamily: 'Ralweay',
                                fontWeight: FontWeight.w600)),
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime(2020, 6, 7), onChanged: (date) {
                      print('change $date');
                    }, onConfirm: (date) {
                      setState(() {
                        time = date;
                        print(time.toString() + " why XD");
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.es);
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: devicesize.screenWidth(context) * 0.613,
                    height: devicesize.screenHeight(context) * 0.0296,
                    decoration: BoxDecoration(
                        color: custcolor.greyColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: devicesize.screenWidth(context) * 0.189,
                          height: devicesize.screenHeight(context) * 0.0296,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: custcolor.almostWhite,
                              borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            "Fecha",
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    devicesize.screenHeight(context) * 0.0145),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: devicesize.screenWidth(context) * 0.162)),
                        time != null
                            ? Text(
                                DateFormat.d().format(time).toString() +
                                    "/" +
                                    DateFormat.M().format(time).toString() +
                                    "  " +
                                    DateFormat.Hms().format(time).toString(),
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontWeight: FontWeight.w600,
                                    fontSize: devicesize.screenHeight(context) *
                                        0.017),
                              )
                            : Text(""),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: devicesize.screenHeight(context) * 0.013,
            bottom: devicesize.screenHeight(context) * 0.013,
            right: devicesize.screenWidth(context) * 0.41
          ),
          child: Text(
            "Descripción",
            style: TextStyle(
                fontSize: devicesize.screenHeight(context) * 0.026,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
                color:custcolor.almostWhite),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: devicesize.screenWidth(context) * 0.52,
              height: devicesize.screenHeight(context) * 0.171,
              decoration: BoxDecoration(
                  color: custcolor.almostBlack,
                  borderRadius: BorderRadius.circular(
                      devicesize.screenHeight(context) * 0.018)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: devicesize.screenHeight(context) * 0.0165),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: devicesize.screenWidth(context) * 0.139,
                      height: devicesize.screenHeight(context) * 0.053,
                      decoration: BoxDecoration(
                        color: custcolor.almostBlack,
                        borderRadius: BorderRadius.circular(
                            devicesize.screenHeight(context) * 0.012),
                      ),
                      child: Icon(custicon.Add.add, color: custcolor.almostWhite),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: devicesize.screenHeight(context) * 0.006),
                    child: GestureDetector(
                      child: Container(
                        width: devicesize.screenWidth(context) * 0.139,
                        height: devicesize.screenHeight(context) * 0.053,
                        decoration: BoxDecoration(
                          color: custcolor.almostBlack,
                          borderRadius: BorderRadius.circular(
                              devicesize.screenHeight(context) * 0.012),
                        ),
                        child: Icon(custicon.Add.add, color: custcolor.almostWhite),
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                      width: devicesize.screenWidth(context) * 0.139,
                      height: devicesize.screenHeight(context) * 0.053,
                      decoration: BoxDecoration(
                        color: custcolor.almostBlack,
                        borderRadius: BorderRadius.circular(devicesize.screenHeight(context) * 0.012),
                      ),
                      child: Icon(custicon.Add.add, color: custcolor.almostWhite),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(top: devicesize.screenHeight(context) * 0.03, ),
          child: GestureDetector(
            child: Container(
              height: devicesize.screenHeight(context) * 0.0567,
              width: devicesize.screenWidth(context) * 0.2824,
              decoration: BoxDecoration(
                color: custcolor.almostWhite,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: custcolor.almostBlack,
                      offset: Offset(8.0, 8.0),
                      blurRadius: 10)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Listo",
                    style: TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w800,
                        fontSize: devicesize.screenHeight(context) * 0.025),
                  ),
                  Icon(
                    custicon.QuickStrike.quickstrike,
                    color: custcolor.almostBlack,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
