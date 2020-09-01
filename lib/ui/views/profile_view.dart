import 'dart:math';

import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/ui/widgets/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../shared/shared_styles.dart';
import '../../viewmodels/profile_view_model.dart';
import 'dart:ui';

class ProfileView extends StatelessWidget {
  final phoneController = TextEditingController();
  final mailController = TextEditingController();
  final genderController = TextEditingController();
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onModelReady: (model) {
        if (phoneController.text.isEmpty)
          phoneController.text = model.currentUser.phoneNumber;
        if (mailController.text.isEmpty)
          mailController.text = model.currentUser.email;
        if (genderController.text.isEmpty)
          genderController.text = model.currentUser.gender;
        if (addressController.text.isEmpty)
          addressController.text = model.currentUser.address;
      },
      builder: (context, model, child) => Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Stack(
                      overflow: Overflow.visible,
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                image: (model.currentUser.bkdPicUrl != null ||
                                        model.selectedBkdImage != null)
                                    ? DecorationImage(
                                        image: model.selectedBkdImage != null
                                            ? FileImage(model.selectedBkdImage)
                                            : NetworkImage(
                                                model.currentUser.bkdPicUrl),
                                        fit: BoxFit.cover)
                                    : null),
                            width: double.infinity,
                            child: model.selectedBkdImage == null
                                ? GestureDetector(
                                    onTap: () {
                                      if (model.isEditting)
                                        model.selectBkdImage();
                                    },
                                    child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color:
                                                model.currentUser.bkdPicUrl ==
                                                        null
                                                    ? Color(0xff223C47)
                                                    : (model.isEditting
                                                        ? Colors.black45
                                                        : null)),
                                        child: model.isEditting
                                            ? Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 40,
                                              )
                                            : Container()),
                                  )
                                : Container()),
                        Positioned(
                          left: screenWidth(context) * 0.055,
                          top: usableScreenWithoughtBars(context) * 0.025,
                          child: Container(
                            decoration: profilePicDecoration,
                            child: CircleAvatar(
                                child: (model.isEditting &&
                                        model.selectedProfileImage == null)
                                    ? Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.black45),
                                        child: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                      )
                                    : Container(),
                                radius:
                                    usableScreenWithoughtBars(context) * 0.07,
                                backgroundImage: model.selectedProfileImage !=
                                        null
                                    ? FileImage(model.selectedProfileImage)
                                    : (model.currentUser.picUrl != null)
                                        ? NetworkImage(model.currentUser.picUrl)
                                        : AssetImage(
                                            "assets/images/default-profile.png")),
                          ),
                        ),
                        Positioned(
                          left: screenWidth(context) * 0.038,
                          top: usableScreenWithoughtBars(context) * 0.029,
                          child: model.currentUser.winCount == 1
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(200),
                                    ),
                                  ),
                                  width: screenWidth(context) * 0.26,
                                  height: screenWidth(context) * 0.22,
                                  child:
                                      getDecoration(model.currentUser.winCount),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(200),
                                    ),
                                  ),
                                  width: screenWidth(context) * 0.26,
                                  height: screenWidth(context) * 0.26,
                                  child:
                                      getDecoration(model.currentUser.winCount),
                                ),
                        ),
                        Positioned(
                            left: screenWidth(context) * 0.075,
                            top: usableScreenWithoughtBars(context) * 0.03,
                            child: Container(
                              width: screenWidth(context) * 0.18,
                              height: screenHeight(context) * 0.09,
                              child: GestureDetector(
                                onTap: () => model.selectProfileImage(),
                              ),
                            )),
                        Positioned(
                          top: screenHeight(context) * 0.02,
                          right: screenWidth(context) * 0.04,
                          child: GestureDetector(
                            onTap: () => model.seeSettings(),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 1.0,
                                  top: 1.0,
                                  child: Icon(
                                    Icons.settings,
                                    color: Colors.black54,
                                  ),
                                ),
                                Icon(Icons.settings, color: blueTheme),
                              ],
                            ),
                          ),
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
                              height: usableScreenWithoughtBars(context) * 0.1,
                              width: double.infinity,
                              color: Color(0xff3C8FA7).withOpacity(0.6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(model.currentUser.name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontFamily: "Raleway",
                                          fontWeight: FontWeight.w600)),
                                  Transform.rotate(
                                    angle: model.isShowingInfo ? pi : 0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.expand_more,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        model.toggleInfo();
                                      },
                                      iconSize: 40,
                                    ),
                                  )
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
                        postsCount: model.currentUser.postsCount.toString(),
                        winCount: model.currentUser.winCount.toString(),
                        communitiesCount:
                            model.currentUser.communities.length.toString(),
                        model: model,
                        vouchCount: model.currentUser.vouches.length.toString(),
                      ),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 6.0,
                            sigmaY: 6.0,
                          ),
                          child: Container(
                            color: Color(0xff3C8FA7).withOpacity(0.6),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 250),
                              width: screenWidth(context),
                              height: model.isShowingInfo
                                  ? usableScreenHeight(context) * 0.3
                                  : 0,
                              decoration: BoxDecoration(
                                border: model.isShowingInfo
                                    ? Border(
                                        top: BorderSide(
                                            width: 2, color: Colors.white))
                                    : null,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Row(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Mail: ",
                                                  style:
                                                      profileDropdownTextStyle,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Teléfono: ",
                                                  style:
                                                      profileDropdownTextStyle,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Género: ",
                                                  style:
                                                      profileDropdownTextStyle,
                                                )),
                                            Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Dirección: ",
                                                  style:
                                                      profileDropdownTextStyle,
                                                )),
                                          ],
                                        ),
                                        Expanded(
                                          child: model.isEditting
                                              ? Column(
                                                  children: <Widget>[
                                                    Expanded(
                                                        child: TextField(
                                                      controller:
                                                          mailController,
                                                      readOnly: true,
                                                      style:
                                                          profileDropdownTextStyle,
                                                      decoration:
                                                          profileDropDownInputDecoration,
                                                    )),
                                                    Expanded(
                                                        child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .phone,
                                                            controller:
                                                                phoneController,
                                                            style:
                                                                profileDropdownTextStyle,
                                                            decoration:
                                                                profileDropDownInputDecoration)),
                                                    Expanded(
                                                        child: TextField(
                                                            controller:
                                                                genderController,
                                                            style:
                                                                profileDropdownTextStyle,
                                                            decoration:
                                                                profileDropDownInputDecoration)),
                                                    Expanded(
                                                        child: TextField(
                                                            controller:
                                                                addressController,
                                                            style:
                                                                profileDropdownTextStyle,
                                                            decoration:
                                                                profileDropDownInputDecoration)),
                                                  ],
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        model.currentUser
                                                                    .email !=
                                                                null
                                                            ? model.currentUser
                                                                .email
                                                            : '',
                                                        style:
                                                            profileDropdownTextStyle,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        model.currentUser
                                                                    .phoneNumber !=
                                                                null
                                                            ? model.currentUser
                                                                .phoneNumber
                                                            : '',
                                                        style:
                                                            profileDropdownTextStyle,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        model.currentUser
                                                                    .gender !=
                                                                null
                                                            ? model.currentUser
                                                                .gender
                                                            : '',
                                                        style:
                                                            profileDropdownTextStyle,
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        model.currentUser
                                                                    .address !=
                                                                null
                                                            ? model.currentUser
                                                                .address
                                                            : '',
                                                        style:
                                                            profileDropdownTextStyle,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          model.isEditting
                                              ? IconButton(
                                                  icon: Icon(Icons.clear),
                                                  color: Colors.white,
                                                  iconSize: 30,
                                                  onPressed: () =>
                                                      model.cancelChanges())
                                              : Container(),
                                          !model.busy
                                              ? IconButton(
                                                  icon: Icon(
                                                    model.isEditting
                                                        ? Icons.check
                                                        : Icons.edit,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    model.isEditting
                                                        ? model.saveChanges(
                                                            email:
                                                                mailController
                                                                    .text,
                                                            phoneNumber:
                                                                phoneController
                                                                    .text,
                                                            gender:
                                                                genderController
                                                                    .text,
                                                            address:
                                                                addressController
                                                                    .text)
                                                        : model.editProfile();
                                                  },
                                                  iconSize: 30,
                                                )
                                              : SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child:
                                                      CircularProgressIndicator()),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          )),
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
    return Container();
  }
}
