import 'package:aldea/ui/widgets/bottom_filler.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/ui/widgets/vouch_item.dart';
import 'package:aldea/viewmodels/vouch_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';

import "../shared/app_colors.dart" as custcolor;
import "../shared/ui_helpers.dart" as devicesize;

class VouchView extends StatelessWidget {
  final String uid;
  const VouchView(this.uid);
  @override
  Widget build(BuildContext context) {
    final double screenHeight = devicesize.screenHeight(context) * 0.1043;
    return ViewModelBuilder<VouchViewModel>.reactive(
        viewModelBuilder: () => VouchViewModel(),
        onModelReady: (model) => model.fetchPosts(uid),
        builder: (context, model, child) => Scaffold(
                body: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    NotchFiller(),
                  ],
                ),
                model.posts != null
                    ? Column(
                        children: <Widget>[
                          NotchFiller(),
                          Container(
                            width: devicesize.screenWidth(context),
                            height: devicesize.screenHeight(context) * 0.103,
                            color: custcolor.darkGrey,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: devicesize.screenWidth(context) *
                                          0.015),
                                  child: Image.asset(
                                    "assets/images/vouch.png",
                                    color: custcolor.blueTheme,
                                    height:
                                        devicesize.screenHeight(context) * 0.07,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: devicesize.screenHeight(context) *
                                          0.035),
                                  child: Text(
                                    "Vouch",
                                    style: TextStyle(
                                        color: custcolor.almostWhite,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            devicesize.screenHeight(context) *
                                                0.026),
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.all(0),
                                itemCount: model.posts.length > 9
                                    ? model.posts.length
                                    : 9,
                                itemBuilder: (context, index) {
                                  return index < model.posts.length
                                      ? VouchItem(
                                          goToProfile: () => model.goToProfile(
                                              model.posts[index].uid),
                                          vouch: model.posts[index],
                                          index: index,
                                        )
                                      : Container(
                                          color: index % 2 == 0
                                              ? custcolor.backgroundColor
                                              : custcolor.darkGrey,
                                          width:
                                              devicesize.screenWidth(context),
                                          height:
                                              devicesize.screenHeight(context) *
                                                  0.103,
                                        );
                                }),
                          ),
                          BottomFiller(),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              custcolor.blueishGreyColor),
                        ),
                      )
              ],
            )));
  }
}
