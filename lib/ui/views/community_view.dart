import 'dart:ui';
import 'package:aldea/constants/languages.dart';
import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/views/user_posts_view.dart';
import 'package:aldea/ui/views/news_view.dart';
import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/shared_styles.dart';
import 'package:aldea/ui/views/market_view.dart';
import 'package:aldea/ui/widgets/community_rules.dart';
import 'package:aldea/ui/widgets/confirm_popup_unfollow.dart';
import 'package:aldea/ui/widgets/creation_popup.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../shared/ui_helpers.dart';
import '../../viewmodels/community_view_model.dart';
import 'community_chat_view.dart';

class CommunityView extends StatefulWidget {
  final Community community;
  const CommunityView({Key key, this.community}) : super(key: key);

  @override
  _CommunityViewState createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isModerator;

    return ViewModelBuilder<CommunityViewModel>.reactive(
        viewModelBuilder: () => CommunityViewModel(widget.community),
        onModelReady: (model) async {
          if (widget.community.moderators.contains(model.currentUser.uid))
            model.getRequests(widget.community.uid);
          await model.fetchProducts(widget.community.uid);
          _tabController = widget.community.isMarketplace
              ? TabController(vsync: this, length: 5, initialIndex: 0)
              : TabController(vsync: this, length: 4, initialIndex: 0);
          _tabController.addListener(() => {
                _scrollController.animateTo(240,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease)
              });
          _scrollController = ScrollController();
        },
        builder: (context, model, child) {
          isModerator =
              widget.community.moderators.contains(model.currentUser.uid);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xff0F1013),
            body: Column(
              children: <Widget>[
                NotchFiller(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  width: double.infinity,
                  height: usableScreenHeight(context) * 0.1,
                  alignment: Alignment.centerLeft,
                  color: const Color(0xff17191E),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        widget.community.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Linguineve',
                            fontSize: 40),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        child: Row(
                          children: [
                            if (model.community.moderators
                                    .contains(model.currentUser.uid) !=
                                true)
                              IconButton(
                                  icon: Icon(Icons.more_vert,
                                      color: almostWhite, size: 35),
                                  onPressed: () {
                                    model.setDropdownContainer();
                                  }),
                            model.currentUser.isGodAdmin
                                ? IconButton(
                                    icon: Icon(Icons.dangerous,
                                        color: Colors.red, size: 35),
                                    onPressed: () => model.setDeleteCommunity(),
                                  )
                                : Container(),
                            model.community.moderators
                                    .contains(model.currentUser.uid)
                                ? getModButtons(model)
                                : Container()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                model.busy
                    ? Container(
                        height: screenHeight(context) * 0.8,
                        width: screenWidth(context),
                        child: Center(child: const CircularProgressIndicator()))
                    : Stack(
                        children: <Widget>[
                          Container(
                            height: communityBodyHeight(context),
                            width: double.infinity,
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    height: communityBodyHeight(context) * 0.35,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(widget
                                                      .community.bkdPicUrl),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Positioned(
                                            top: communityBodyHeight(context) *
                                                0.04,
                                            child: Container(
                                                decoration:
                                                    profilePicDecoration,
                                                child: CircleAvatar(
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    radius: communityBodyHeight(
                                                            context) *
                                                        0.07,
                                                    backgroundImage:
                                                        NetworkImage(widget
                                                            .community
                                                            .iconPicUrl)))),
                                        ClipRect(
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 5.0, sigmaY: 5.0),
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: communityBodyHeight(
                                                        context) *
                                                    0.06,
                                              ),
                                              width: double.infinity,
                                              height:
                                                  communityBodyHeight(context) *
                                                      0.08,
                                              color: Colors.black38,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    onTap: widget.community
                                                            .moderators
                                                            .contains(model
                                                                .currentUser
                                                                .uid)
                                                        ? () => model
                                                            .goToAdminUsersScreen(
                                                                model.community)
                                                        : "",
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                            widget.community
                                                                .postsCount
                                                                .toString(),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18)),
                                                        Text(
                                                            languages[model
                                                                    .currentLanguage]
                                                                ["posts"],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                fontSize: 16))
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: widget.community
                                                              .moderators
                                                              .contains(model
                                                                  .currentUser
                                                                  .uid)
                                                          ? () => model
                                                              .goToAdminUsersScreen(
                                                                  model
                                                                      .community)
                                                          : "",
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () => model
                                                          .goToAdminUsersScreen(
                                                              model.community),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                              widget.community
                                                                  .followerCount
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      18)),
                                                          Text(
                                                              languages[model
                                                                      .currentLanguage]
                                                                  ["followers"],
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                  fontSize: 16))
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xff17191E),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: Offset(0, 4))
                                        ]),
                                    height: communityBodyHeight(context) * 0.08,
                                    width: double.infinity,
                                    child: widget.community.isMarketplace
                                        ? TabBar(
                                            controller: _tabController,
                                            indicatorColor: Colors.white,
                                            tabs: [
                                              SizedBox(
                                                  height: communityBodyHeight(
                                                          context) *
                                                      0.04,
                                                  child: Image.asset(
                                                      "assets/images/reglas.png")),
                                              SizedBox(
                                                  height: communityBodyHeight(
                                                          context) *
                                                      0.04,
                                                  child: Image.asset(
                                                      "assets/images/posts.png")),
                                              SizedBox(
                                                  height: communityBodyHeight(
                                                          context) *
                                                      0.04,
                                                  child: Image.asset(
                                                      "assets/images/cart.png")),
                                              SizedBox(
                                                  height: communityBodyHeight(
                                                          context) *
                                                      0.04,
                                                  child: Image.asset(
                                                      "assets/images/community-chat.png")),
                                              GestureDetector(
                                                child: SizedBox(
                                                    height: communityBodyHeight(
                                                            context) *
                                                        0.04,
                                                    child: Image.asset(
                                                        "assets/images/user-posts.png")),
                                              ),
                                            ],
                                          )
                                        : TabBar(
                                            controller: _tabController,
                                            indicatorColor: Colors.white,
                                            tabs: [
                                              SizedBox(
                                                  height: communityBodyHeight(
                                                          context) *
                                                      0.04,
                                                  child: Image.asset(
                                                      "assets/images/reglas.png")),
                                              SizedBox(
                                                  height: communityBodyHeight(
                                                          context) *
                                                      0.04,
                                                  child: Image.asset(
                                                      "assets/images/posts.png")),
                                              SizedBox(
                                                  height: communityBodyHeight(
                                                          context) *
                                                      0.04,
                                                  child: Image.asset(
                                                      "assets/images/community-chat.png")),
                                              SizedBox(
                                                  height: communityBodyHeight(
                                                          context) *
                                                      0.04,
                                                  child: Image.asset(
                                                      "assets/images/user-posts.png")),
                                            ],
                                          ),
                                  ),
                                  isModerator
                                      ? GestureDetector(
                                          onTap: () => model.goToRequests(),
                                          child: Container(
                                            height:
                                                screenHeight(context) * 0.052,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              boxShadow: [
                                                const BoxShadow(
                                                  color: Colors.black38,
                                                  offset:
                                                      const Offset(0.0, 0.0),
                                                ),
                                                const BoxShadow(
                                                  color: Color(0xff17191E),
                                                  offset:
                                                      const Offset(0.0, 0.0),
                                                  spreadRadius: -4.0,
                                                  blurRadius: 12.0,
                                                ),
                                              ],
                                            ),
                                            padding: EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "${languages[model.currentLanguage]["admission1"]} ",
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: screenWidth(
                                                                  context) *
                                                              0.04,
                                                          color: Colors.white,
                                                          fontFamily:
                                                              'Raleway'),
                                                    ),
                                                    Text(
                                                      "${model.requests.length} ${languages[model.currentLanguage]["admission2"]}  ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          fontSize: screenWidth(
                                                                  context) *
                                                              0.04,
                                                          fontFamily: 'Raleway',
                                                          color: Color(
                                                              0xff3CA759)),
                                                    ),
                                                    Text(
                                                        "${languages[model.currentLanguage]["admission3"]}",
                                                        style: TextStyle(
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Raleway'))
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: screenHeight(
                                                              context) *
                                                          0.2),
                                                  child: Icon(Icons.add,
                                                      color: Color(0xff3CA759)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  Container(
                                    height: communityBodyHeight(context) * 0.92,
                                    width: double.infinity,
                                    child: widget.community.isMarketplace
                                        ? TabBarView(
                                            controller: _tabController,
                                            children: [
                                                CommunityRules(
                                                  community: widget.community,
                                                  isEditting: false,
                                                ),
                                                NewsView(
                                                    community:
                                                        widget.community),
                                                MarketView(widget.community,
                                                    model.products),
                                                CommunityChatView(
                                                  petitionsShowing: isModerator,
                                                  communityId:
                                                      this.widget.community.uid,
                                                ),
                                                UserPostsView(
                                                    community:
                                                        widget.community),
                                              ])
                                        : TabBarView(
                                            controller: _tabController,
                                            children: [
                                                CommunityRules(
                                                  community: widget.community,
                                                  isEditting: false,
                                                ),
                                                NewsView(
                                                    community:
                                                        widget.community),
                                                CommunityChatView(
                                                  petitionsShowing: isModerator,
                                                  communityId:
                                                      this.widget.community.uid,
                                                ),
                                                UserPostsView(
                                                    community:
                                                        widget.community),
                                              ]),
                                  )
                                ],
                              ),
                            ),
                          ),
                          if (model.isShowingPopup) Padding(
                            padding: EdgeInsets.only(top:  screenHeight(context) * 0.1,),
                            child: Center(child: CreationPopup(model)),
                          ),
                          if (model.unfollowPopup)
                            Positioned(
                              top: screenHeight(context) * 0.25,
                              left: screenWidth(context) * 0.15,
                              child: UnfollowPopUp(context, model),
                            ),
                          model.unfollowDropdown
                              ? Positioned(
                                  top: screenHeight(context) * 0.03,
                                  right: screenWidth(context) * 0.07,
                                  child: GestureDetector(
                                      onTap: () {
                                        model.setDropdownContainer();
                                        model.setIsUnfollowPopup();
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            color: almostWhite,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                10,
                                              ),
                                            ),
                                          ),
                                          width: screenWidth(context) * 0.3,
                                          height: screenHeight(context) * 0.05,
                                          child: Center(
                                              child: Text(
                                            "Dejar de seguir",
                                            style: TextStyle(
                                              color: almostBlack,
                                              fontFamily: 'Raleway',
                                            ),
                                          )))))
                              : Container(),
                          model.deletingCommunity
                              ? Positioned(
                                  top: screenHeight(context) * 0.25,
                                  left: screenWidth(context) * 0.15,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 6.0, sigmaY: 6.0),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50),
                                              ),
                                              color: Colors.white
                                                  .withOpacity(0.2)),
                                          width: screenWidth(context) * 0.7,
                                          height: screenHeight(context) * 0.3,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    screenWidth(context) *
                                                        0.05),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                          screenWidth(context) *
                                                              0.04,
                                                      right:
                                                          screenWidth(context) *
                                                              0.04,
                                                      top: screenHeight(
                                                              context) *
                                                          0.04),
                                                  child: Text(
                                                    "¿Estás seguro que quieres eliminar ${model.community.name}?",
                                                    style: TextStyle(
                                                      color: almostWhite,
                                                      fontFamily: "Raleway",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: screenHeight(
                                                              context) *
                                                          0.02),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          model
                                                              .deleteCommunity();
                                                        },
                                                        child: Container(
                                                            width: screenWidth(
                                                                    context) *
                                                                0.24,
                                                            height: screenHeight(
                                                                    context) *
                                                                0.06,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    almostWhite,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            200))),
                                                            child: Center(
                                                                child: Text(
                                                              "Sí",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Raleway",
                                                                  color:
                                                                      almostBlack,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ))),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          model
                                                              .setNotDeleteCommunity();
                                                        },
                                                        child: Container(
                                                            width: screenWidth(
                                                                    context) *
                                                                0.24,
                                                            height: screenHeight(
                                                                    context) *
                                                                0.06,
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    blueTheme,
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            200))),
                                                            child: Center(
                                                                child: Text(
                                                              "No",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Raleway",
                                                                  color:
                                                                      almostWhite,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ))),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    ),
                                  ))
                              : Container()
                        ],
                      )
              ],
            ),
          );
        });
  }

  Widget getModButtons(CommunityViewModel model) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: screenWidth(context) * 0.0),
          child: IconButton(
            onPressed: () {
              model.setIsShowingPopup(true);
            },
            icon: Icon(
              Icons.note_add,
              size: 35,
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            model.goToSettings(widget.community);
          },
          icon: Icon(
            Icons.settings,
            size: 35,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
