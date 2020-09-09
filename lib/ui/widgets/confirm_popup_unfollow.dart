import 'dart:ui';

import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/viewmodels/community_view_model.dart';
import 'package:flutter/material.dart';

class UnfollowPopUp extends StatelessWidget {
  final BuildContext context;
  final CommunityViewModel model;

  UnfollowPopUp(this.context, this.model);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
                color: Colors.white.withOpacity(0.2)),
            width: screenWidth(context) * 0.7,
            height: screenHeight(context) * 0.3,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.05),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth(context) * 0.04,
                        right: screenWidth(context) * 0.04,
                        top: screenHeight(context) * 0.04),
                    child: Text(
                      "¿Estás seguro que quieres dejar de seguir a ${model.community.name}?",
                      style: TextStyle(
                        color: almostWhite,
                        fontFamily: "Raleway",
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight(context) * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            model.unfollowCommunity();
                          },
                          child: Container(
                              width: screenWidth(context) * 0.24,
                              height: screenHeight(context) * 0.06,
                              decoration: BoxDecoration(
                                  color: almostWhite,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(200))),
                              child: Center(
                                  child: Text(
                                "Sí",
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                    color: almostBlack,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ))),
                        ),
                        GestureDetector(
                          onTap: () {
                            model.setIsUnfollowPopup();
                          },
                          child: Container(
                              width: screenWidth(context) * 0.24,
                              height: screenHeight(context) * 0.06,
                              decoration: BoxDecoration(
                                  color:blueTheme,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(200))),
                              child: Center(
                                  child: Text(
                                "No",
                                style: TextStyle(
                                    fontFamily: "Raleway",
                                  color: almostWhite,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ))),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
