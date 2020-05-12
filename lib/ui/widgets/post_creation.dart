import "package:flutter/material.dart";
import "../shared/ui_helpers.dart" as devicesize;
import "../shared/app_colors.dart" as custcolor;
import "package:aldea/constants/icondata.dart" as custicon;

class PostCreation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color blackColor = custcolor.almostBlack;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: devicesize.screenHeight(context) * 0.0221),
          child: Container(
            color: custcolor.almostWhite,
            width: devicesize.screenWidth(context) * 0.6898,
            height: 2,
          ),
        ),
        Padding(
          padding:  EdgeInsets.only(right: devicesize.screenWidth(context) * 0.4),
          child: Text(
            "Descripción",
            
            style: TextStyle(
                fontSize: devicesize.screenHeight(context) * 0.027,
                fontWeight: FontWeight.w600,
                fontFamily: 'Raleway',
                color: custcolor.almostWhite),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: devicesize.screenHeight(context) * 0.02,
              bottom: devicesize.screenHeight(context) * 0.025),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: devicesize.screenWidth(context) * 0.685,
            height: devicesize.screenHeight(context) * 0.312,
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.circular(devicesize.screenHeight(context) * 0.012),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Escribe una descripción...",
                hintStyle: TextStyle(
                    color: custcolor.almostWhite,
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                labelStyle: TextStyle(color: custcolor.almostWhite),
                border: InputBorder.none,
                fillColor: custcolor.almostWhite,
              ),
              style: TextStyle(fontFamily: "Raleway", color: custcolor.almostWhite),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              right: devicesize.screenWidth(context) * 0.03, left: devicesize.screenWidth(context) * 0.03, bottom: devicesize.screenHeight(context) * 0.01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                child: Container(
                    width: devicesize.screenWidth(context) * 0.206,
                    height: devicesize.screenHeight(context) * 0.0985,
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(
                            devicesize.screenHeight(context) * 0.018)),
                    child: Icon(custicon.Add.add,
                        color: custcolor.almostWhite,
                        size: devicesize.screenHeight(context) * 0.036)),
              ),
              GestureDetector(
                child: Container(
                    width: devicesize.screenWidth(context) * 0.206,
                    height: devicesize.screenHeight(context) * 0.0985,
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(
                            devicesize.screenHeight(context) * 0.018)),
                    child: Icon(
                      custicon.Add.add,
                      color:custcolor.almostWhite,
                      size: devicesize.screenHeight(context) * 0.036,
                    )),
              ),
              GestureDetector(
                child: Container(
                    width: devicesize.screenWidth(context) * 0.206,
                    height: devicesize.screenHeight(context) * 0.0985,
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(
                            devicesize.screenHeight(context) * 0.018)),
                    child: Icon(custicon.Add.add,
                        color: custcolor.almostWhite,
                        size: devicesize.screenHeight(context) * 0.036)),
              )
            ],
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: devicesize.screenHeight(context) * 0.022),
          child: GestureDetector(
            child: Container(
              width: devicesize.screenWidth(context) * 0.282,
              height: devicesize.screenHeight(context) * 0.056,
              decoration: BoxDecoration(
                color: custcolor.almostWhite,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      offset: Offset(8.0, 8.0),
                      blurRadius: 10)
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("Listo",
                      style: TextStyle(
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w800,
                          color: blackColor,
                          fontSize: devicesize.screenHeight(context) * 0.025)),
                  Padding(
                    padding: EdgeInsets.only(
                        right: devicesize.screenHeight(context) * 0.012),
                    child: Icon(
                      custicon.Publicaciones.publicaciones,
                      color: blackColor,
                      size: devicesize.screenHeight(context) * 0.020,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
