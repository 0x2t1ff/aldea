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
                                      image: model.userData.bkdPicUrl != null
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  model.userData.bkdPicUrl),
                                              fit: BoxFit.cover)
                                          : null),
                                  width: double.infinity,
                                ),
                                Positioned(
                                    left: screenWidth(context) * 0.055,
                                    top: usableScreenWithoughtBars(context) *
                                        0.025,
                                    child: Container(
                                      decoration: profilePicDecoration,
                                      child: CircleAvatar(
                                          radius: usableScreenWithoughtBars(
                                                  context) *
                                              0.07,
                                          backgroundImage:
                                              model.userData.picUrl != null
                                                  ? NetworkImage(
                                                      model.userData.picUrl)
                                                  : null),
                                    )),
                                model.currentUser.isGodAdmin
                                    ? Positioned(
                                        top: 10,
                                        right: 10,
                                        child: GestureDetector(
                                          onTap: () => model.banUser(),
                                          child: Container(
                                            child: Icon(
                                              Icons.delete_outline_rounded,
                                              color: Colors.red,
                                              size: 35,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Positioned(
                                  left: screenWidth(context) * 0.038,
                                  top: usableScreenWithoughtBars(context) *
                                      0.029,
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(200),
                                        ),
                                      ),
                                      width: screenWidth(context) * 0.26,
                                      height: screenWidth(context) * 0.26,
                                      child: getDecoration(
                                          model.userData.winCount)),
                                ),
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
                                            icon: model.isOpening
                                                ? CircularProgressIndicator()
                                                : Icon(
                                                    Icons.mail,
                                                    color: Colors.white,
                                                  ),
                                            onPressed: () {
                                              if (!model.isOpening) {
                                                model.openChat(model.user.uid);
                                              }
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

  Widget getDecoration(int wins) {
    if (wins >= 1 && wins < 5) {
      return Image.asset("assets/images/laureles.png");
    } else if (wins >= 5 && wins < 10) {
      return Image.asset("assets/images/bronce.png");
    } else if (wins >= 10 && wins < 20) {
      return Image.asset("assets/images/plata.png");
    } else if (wins >= 20 && wins < 30) {
      return Image.asset("assets/images/oro.png");
    } else if (wins >= 30) {
      return Image.asset("assets/images/platino.png");
    }
    print("it was 0");
    return Container();
  }
}
