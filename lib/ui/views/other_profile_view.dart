import 'dart:math';
import 'package:aldea/ui/widgets/notch_filler.dart';

import "../shared/app_colors.dart" as custcolor;
import "../shared/ui_helpers.dart" as device;
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../shared/shared_styles.dart';
import '../../viewmodels/other_profile_view_model.dart';
import 'dart:ui';

class OtherProfileView extends StatelessWidget {
  final String targetUser;

  OtherProfileView({this.targetUser});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OtherProfileViewModel>.reactive(
      viewModelBuilder: () => OtherProfileViewModel(),
      onModelReady: (model) {
        model.fetchUser(targetUser);
      },
      builder: (context, model, child) => Scaffold(
          body: model.user == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                  ),
                )
              : Container(
                  color: custcolor.darkGrey,
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
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
                                child: Image.asset('assets/images/hoguera.png'))
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Stack(
                              overflow: Overflow.visible,
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              model.userData.bkdPicUrl),
                                          fit: BoxFit.cover)),
                                  width: double.infinity,
                                ),
                                Positioned(
                                    left: screenWidth(context) * 0.05,
                                    top: usableScreenWithoughtBars(context) *
                                        0.04,
                                    child: Container(
                                      decoration: profilePicDecoration,
                                      child: CircleAvatar(
                                          radius: usableScreenWithoughtBars(
                                                  context) *
                                              0.07,
                                          backgroundImage: NetworkImage(
                                              model.userData.picUrl)),
                                    )),
                                Positioned(
                                    child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 6.0,
                                      sigmaY: 6.0,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      height:
                                          usableScreenWithoughtBars(context) *
                                              0.1,
                                      width: double.infinity,
                                      color: Color(0xff3C8FA7).withOpacity(0.6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(model.userData.name,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontFamily: "Raleway",
                                                  fontWeight: FontWeight.w600)),
                                          IconButton(
                                            icon: Icon(
                                              Icons.mail,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              print("button pressed");
                                              model.openChat(model.user.uid);
                                            },
                                            iconSize: 40,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                              ])),
                      Expanded(
                          flex: 2,
                          child: Stack(
                            children: <Widget>[
                              ProfileBody(
                                postsCount:
                                    model.userData.postsCount.toString(),
                                winCount: model.userData.winCount.toString(),
                                communitiesCount: model
                                    .userData.communities.length
                                    .toString(),
                                otherModel: model,
                                vouchCount:
                                    model.userData.vouches.length.toString(),
                              ),
                              ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                    sigmaX: 6.0,
                                    sigmaY: 6.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ))),
    );
  }
}
