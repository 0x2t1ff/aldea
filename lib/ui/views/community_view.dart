import 'package:aldea/models/community.dart';
import 'package:aldea/ui/shared/shared_styles.dart';
import 'package:aldea/ui/views/market_view.dart';
import 'package:aldea/ui/widgets/community_rules.dart';
import 'package:aldea/ui/widgets/notch_filler.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import '../shared/ui_helpers.dart';
import '../../viewmodels/community_view_model.dart';

class CommunityView extends StatelessWidget {
  final Community community;

  const CommunityView({Key key, this.community}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CommunityViewModel>.withConsumer(
        viewModel: CommunityViewModel(),
        builder: (context, model, child) => Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xff0F1013),
              body: Column(
                children: <Widget>[
                  NotchFiller(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    width: double.infinity,
                    height: usableScreenHeight(context) * 0.1,
                    alignment: Alignment.centerLeft,
                    color: Color(0xff17191E),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          community.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Linguineve',
                              fontSize: 40),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  DefaultTabController(
                    length: 5,
                    child: Container(
                      height: communityBodyHeight(context),
                      width: double.infinity,
                      child: SingleChildScrollView(
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
                                            image: NetworkImage(
                                                community.bkdPicUrl),
                                            fit: BoxFit.cover)),
                                  ),
                                  Positioned(
                                      top: communityBodyHeight(context) * 0.04,
                                      child: Container(
                                          decoration: profilePicDecoration,
                                          child: CircleAvatar(
                                              child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              radius:
                                                  communityBodyHeight(context) *
                                                      0.07,
                                              backgroundImage: NetworkImage(
                                                  community.iconPicUrl)))),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal:
                                          communityBodyHeight(context) * 0.06,
                                    ),
                                    width: double.infinity,
                                    height: communityBodyHeight(context) * 0.08,
                                    color: Colors.black38,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("2201",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            Text("Publicaciones",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16))
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("2201",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            Text("Likes",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16))
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text("2201",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                            Text("Seguidores",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                      top: communityBodyHeight(context) * 0.01,
                                      right:
                                          communityBodyHeight(context) * 0.01,
                                      child: DropdownButton(
                                        underline: Container(),
                                        items: [],
                                        onChanged: (a) {},
                                        icon: Icon(
                                          Icons.more_vert,
                                          size: 45,
                                          color: Colors.white,
                                        ),
                                      ))
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
                              child: TabBar(
                                indicatorColor: Colors.white,
                                tabs: [
                                  SizedBox(
                                      height:
                                          communityBodyHeight(context) * 0.05,
                                      child: Image.asset(
                                          "assets/images/reglas.png")),
                                  SizedBox(
                                      height:
                                          communityBodyHeight(context) * 0.05,
                                      child: Image.asset(
                                          "assets/images/posts.png")),
                                  SizedBox(
                                      height:
                                          communityBodyHeight(context) * 0.05,
                                      child: Image.asset(
                                          "assets/images/cart.png")),
                                  SizedBox(
                                      height:
                                          communityBodyHeight(context) * 0.05,
                                      child: Image.asset(
                                          "assets/images/community-chat.png")),
                                  SizedBox(
                                      height:
                                          communityBodyHeight(context) * 0.05,
                                      child: Image.asset(
                                          "assets/images/user-posts.png")),
                                ],
                              ),
                            ),
                            Container(
                              height: communityBodyHeight(context) * 0.92,
                              width: double.infinity,
                              child: TabBarView(children: [
                                CommunityRules(
                                  community: community,
                                  uid: model.currentUser.uid,
                                ),
                                Container(),
                                MarketView(),
                                Container(),
                                Container()
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
