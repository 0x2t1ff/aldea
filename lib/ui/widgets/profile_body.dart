import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/viewmodels/other_profile_view_model.dart';
import 'package:aldea/viewmodels/profile_view_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../shared/shared_styles.dart';

class ProfileBody extends StatelessWidget {
  final String postsCount;
  final String communitiesCount;
  final String vouchCount;
  final String winCount;
  final ProfileViewModel model;
  final OtherProfileViewModel otherModel;

  ProfileBody(
      {this.postsCount,
      this.communitiesCount,
      this.vouchCount,
      this.winCount,
      this.model,
      this.otherModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
          Widget>[
        Expanded(
          flex: 5,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: usableScreenWithoughtBars(context) * 0.015),
                    decoration: profileBoxesDecoration,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Posts",
                          style: TextStyle(
                              color: Color(0xffB1AFAF),
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: usableScreenWithoughtBars(context) * 0.1,
                          child: Image.asset('assets/images/posts.png'),
                        ),
                        Text(
                          postsCount.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                  )),
              SizedBox(height: usableScreenWithoughtBars(context) * 0.05),
              Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: usableScreenWithoughtBars(context) * 0.01),
                    decoration: profileBoxesDecoration,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Vouch",
                                  style: TextStyle(
                                      color: Color(0xffB1AFAF),
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  vouchCount.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            onTap: () {
                              model == null
                                  ? otherModel
                                      .seeVouches(otherModel.user.uid)
                                  : model.seeVouches(model.currentUser.uid);
                            }),
                        GestureDetector(
                          onTap: () {
                            model == null
                                ? otherModel.giveVouch()
                                : print("pressed");
                          },
                          child: model == null ? Container(

                              height: usableScreenWithoughtBars(context) * 0.12,
                              width: screenWidth(context) * 0.2 , 
                              
                              child:FlareActor(
                                    'assets/animations/vouchAnimation.flr',
                                    fit: BoxFit.cover,
                                    animation: otherModel.animationController,
                                  )) : SizedBox(
                                    height: screenHeight(context) * 0.1,
                                    width: screenWidth(context) * 0.15,
                                    child: Image.asset("assets/images/vouch.png", fit: BoxFit.cover,),),
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
        horizontalSpaceMedium,
        Expanded(
          flex: 4,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: usableScreenWithoughtBars(context) * 0.01),
                  decoration: profileBoxesDecoration,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Aldeas",
                        style: TextStyle(
                            color: Color(0xffB1AFAF),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {
                          model == null
                              ? otherModel
                                  .seeCommunities(otherModel.targetUserId)
                              : model.seeCommunities(model.currentUser.uid);
                        },
                        child: SizedBox(
                          height: usableScreenWithoughtBars(context) * 0.1,
                          child: Image.asset('assets/images/hoguera-azul.png'),
                        ),
                      ),
                      Text(
                        communitiesCount.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: usableScreenWithoughtBars(context) * 0.05),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: usableScreenWithoughtBars(context) * 0.01),
                  decoration: profileBoxesDecoration,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Wins",
                        style: TextStyle(
                            color: Color(0xffB1AFAF),
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      SizedBox(
                          height: usableScreenWithoughtBars(context) * 0.1,
                          child: Image.asset('assets/images/win.png')),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            winCount.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Icon(
                            Icons.star,
                            color: Color(0xffE2DB76),
                            size: 22,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
