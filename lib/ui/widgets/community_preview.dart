import 'dart:ui';

import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/shared_styles.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:aldea/viewmodels/communities_view_model.dart';
import 'package:flutter/material.dart';
import '../../constants/icondata.dart';

class CommunityPreview extends StatelessWidget {
  final CommunitiesViewModel model;
  final Community community;
  final Function cancel;

  const CommunityPreview({Key key, this.model, this.community, this.cancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.transparent,
            image: community != null
                ? DecorationImage(
                    image: NetworkImage(community.bkdPicUrl),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.1), BlendMode.srcOver))
                : null),
        duration: community != null
            ? Duration(milliseconds: 600)
            : Duration(milliseconds: 000),
        curve: Curves.easeOutExpo,
        height: community != null ? screenWidth(context) : 0,
        width: screenWidth(context) * 0.8,
        child: community != null
            ? Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (model.currentUser.isGodAdmin ||
                          model.currentUser.communities
                              .contains(community.uid)) {
                        model.goToCommunity(community);
                      }
                    },
                    child: Expanded(
                        flex: 7,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(25),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: <Widget>[
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    onPressed: cancel),
                              ),
                              Container(
                                  decoration: profilePicDecoration,
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        NetworkImage(community.iconPicUrl),
                                  ))
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 2,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 6.0,
                          sigmaY: 6.0,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          height: double.infinity,
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          color: Color(0xff295463).withOpacity(0.2),
                          child: Text(
                            community.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Color(0xff17191E).withOpacity(0.95),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: screenWidth(context) * 0.023),
                            child: Expanded(
                              child: Container(
                                child: Text(
                                  community.description,
                                  maxLines: 4,
                                  style: TextStyle(
                                    color: Color(0xffB1AFAF),
                                    fontSize: 16,
                                    fontFamily: 'Raleway',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: screenWidth(context) * 0.01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth(context) * 0.03),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Profile.profile,
                                            color: Color(0xff3C8FA7),
                                          ),
                                          horizontalSpaceTiny,
                                          Text(
                                            community.followerCount.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontFamily: 'Raleway',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    horizontalSpaceMedium,
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.photo_filter,
                                          color: Color(0xff3C8FA7),
                                          size: 30,
                                        ),
                                        horizontalSpaceTiny,
                                        Text(
                                          community.postsCount.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                community.isPublic
                                    ? Row(
                                        children: [
                                          IconButton(
                                              icon: Icon(
                                                Icons.input,
                                                color: Color(0xff3C8FA7),
                                                size: 35,
                                              ),
                                              onPressed: () {
                                                model.goToCommunity(community);
                                              }),
                                          IconButton(
                                            icon: model.currentUser.communities
                                                    .contains(community.uid)
                                                ? Icon(
                                                    Icons.person_remove,
                                                    size: 35,
                                                    color: Color(0xff3C8FA7),
                                                  )
                                                : Icon(
                                                    Icons.person_add,
                                                    color: Color(0xff3C8FA7),
                                                    size: 35,
                                                  ),
                                            onPressed: () {
                                              if (model.currentUser.communities
                                                  .contains(community.uid)) {
                                                model.unsubscribeToCommunity(
                                                    community.uid);
                                              } else {
                                                model.subscribeToCommunity(
                                                    community.uid);
                                              }
                                            },
                                          )
                                        ],
                                      )
                                    : IconButton(
                                        icon: model.isSendingRequest
                                            ? CircularProgressIndicator()
                                            : model.currentUser.requests
                                                    .contains(community.uid)
                                                ? Icon(Icons.access_time,
                                                    color: blueTheme, size: 35)
                                                : Icon(
                                                    model.currentUser
                                                            .communities
                                                            .contains(
                                                                community.uid)
                                                        ? Icons.input
                                                        : Icons.person_add,
                                                    color: Color(0xff3C8FA7),
                                                    size: 35,
                                                  ),
                                        onPressed: () {
                                          if (model.currentUser.requests
                                              .contains(community.uid)) {
                                          } else {
                                            if (model.currentUser.communities
                                                .contains(community.uid))
                                              model.goToCommunity(community);
                                            else
                                              model.requestCommunityAcces(
                                                  community, context);
                                          }
                                        })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : Container());
  }
}
