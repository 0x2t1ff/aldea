import 'dart:ui';

import 'package:aldea/models/community.dart';
import 'package:aldea/models/user_model.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/widgets/bottom_filler.dart';
import 'package:aldea/ui/widgets/community_users_moderation_item.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:aldea/viewmodels/community_users_admin_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';

import "../shared/app_colors.dart";
import "../shared/ui_helpers.dart";

class CommunityUsersAdminView extends StatelessWidget {
  final Community community;
  const CommunityUsersAdminView(this.community);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunityUsersAdminViewModel>.reactive(
        viewModelBuilder: () => CommunityUsersAdminViewModel(),
        onModelReady: (model) => model.fetchAllUsers(community.uid),
        builder: (context, model, child) => WillPopScope(
              onWillPop: model.onWillPop,
              child: Scaffold(
                  body: Stack(
                children: <Widget>[
                  model.users != null
                      ? Column(
                          children: <Widget>[
                            NotchFiller(),
                            Container(
                              width: screenWidth(context),
                              height: screenHeight(context) * 0.103,
                              color: darkGrey,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(
                                        right: screenWidth(context) * 0.015),
                                    child: CircleAvatar(
                                      radius: screenWidth(context) * 0.06,
                                      backgroundImage:
                                          NetworkImage(community.iconPicUrl),
                                    ),
                                  ),
                                  Text(
                                    community.name,
                                    style: TextStyle(
                                        color: almostWhite,
                                        fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            screenHeight(context) * 0.026),
                                  ),
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  itemCount: model.users.length < 9
                                      ? 9
                                      : model.users.length,
                                  itemBuilder: (context, index) {
                                    if (model.users.length > index) {
                                      User user = User.fromData(
                                          model.users[index].data);
                                      return CommunityUsersModerationItem(
                                          community: community,
                                          kickMember: () =>
                                              model.selectKicking(user),
                                          promoteMember: () =>
                                              model.selectPromote(user),
                                          index: index,
                                          user: user);
                                    }
                                    return Container(
                                      width: screenWidth(context),
                                      height: screenHeight(context) * 0.103,
                                      color: index % 2 == 0
                                          ? backgroundColor
                                          : darkGrey,
                                    );
                                  }),
                            ),
                            BottomFiller(),
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(blueishGreyColor),
                          ),
                        ),
                  Positioned(
                    left: screenWidth(context) * 0.1,
                    top: screenHeight(context) * 0.35,
                    child: model.showingDialog
                        ? getDialog(
                            context,
                            model.selectedUser,
                            community.name,
                            model.kicking,
                            () => model.unselectDialog(),
                            () => model.kickUser(
                                model.selectedUser.uid, community.uid),
                            () => model.modUser(
                                model.selectedUser.uid, community.uid))
                        : Container(),
                  )
                ],
              )),
            ));
  }

//soy consciente que podria haber pasado el modelo y a chuparla , pero por una mejor optimización y probar un par de cosas he preferido hacer esto like this :)
  Widget getDialog(
      BuildContext context,
      User user,
      String communityName,
      bool kicking,
      Function unselectDialog,
      Function kickUser,
      Function modUser) {
    String name = user.name;
    return ClipRRect(borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 6.0,
          sigmaY:6.0,
        ),
            child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
              color: almostWhite.withOpacity(0.2),
            ),
            width: screenWidth(context) * 0.8,
            height: screenHeight(context) * 0.4,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: screenHeight(context) * 0.04),
                  child: CircleAvatar(
                    radius: screenWidth(context) * 0.09,
                    backgroundImage: NetworkImage(user.picUrl),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth(context) * 0.04,
                      right: screenWidth(context) * 0.04,
                      top: screenHeight(context) * 0.01),
                  child: Text(
                    kicking == true
                        ? "Estas seguro que quieres expulsar a $name de  $communityName?"
                        : "¿Estas seguro que quieres otorgar a $name el puesto de moderador en $communityName? ",
                        textAlign: TextAlign.center,
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
                        //TODO: testing if this works
                        onTap: kicking ? kickUser : modUser,
                        child: Container(
                            width: screenHeight(context) * 0.08,
                            height: screenHeight(context) * 0.08,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(200)),
                            child: Center(
                                child: Icon(Icons.check,
                                    color: almostWhite, size: 35))),
                      ),
                      GestureDetector(
                        onTap: unselectDialog,
                        child: Container(
                            width: screenHeight(context) * 0.08,
                            height: screenHeight(context) * 0.08,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200))),
                            child: Center(
                                child: Icon(Icons.close,
                                    color: almostWhite, size: 40))),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
