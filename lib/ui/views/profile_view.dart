import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../shared/shared_styles.dart';
import '../../viewmodels/profile_view_model.dart';
import 'dart:ui';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProfileViewModel>.withConsumer(
      viewModel: ProfileViewModel(),
      builder: (context, model, child) => Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://scontent-mad1-1.cdninstagram.com/v/t51.2885-15/e35/20902566_1334967203298092_3707662494303518720_n.jpg?_nc_ht=scontent-mad1-1.cdninstagram.com&_nc_cat=108&_nc_ohc=6JQ4m3djnNYAX_9ZH7J&oh=670f1400b6fd54898d77b43c58f8c672&oe=5EC77894"),
                                  fit: BoxFit.cover)),
                          width: double.infinity,
                        ),
                        Positioned(
                            left: screenWidth(context) * 0.05,
                            top: usableScreenWithoughtBars(context) * 0.04,
                            child: Container(
                              decoration: profilePicDecoration,
                              child: CircleAvatar(
                                radius:
                                    usableScreenWithoughtBars(context) * 0.07,
                                backgroundImage: NetworkImage(
                                   model.getUserProfilePicUrl()),
                              ),
                            )),
                        Positioned(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          height: usableScreenWithoughtBars(context) * 0.1,
                          width: double.infinity,
                          color: Color(0xff3C8FA7).withOpacity(0.8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(model.getUserName(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontFamily: "Raleway",
                                      fontWeight: FontWeight.w600)),
                              IconButton(
                                icon: Icon(
                                  Icons.expand_more,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                                iconSize: 40,
                              )
                            ],
                          ),
                        ))
                      ])),
              Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                    width: double.infinity,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    flex: 7,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: usableScreenWithoughtBars(
                                                  context) *
                                              0.015),
                                      decoration: profileBoxesDecoration,
                                      width: double.infinity,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
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
                                            height: usableScreenWithoughtBars(
                                                    context) *
                                                0.1,
                                            child: Image.asset(
                                                'assets/images/posts.png'),
                                          ),
                                          Text(
                                            model.getUserPostsCount(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Raleway",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          )
                                        ],
                                      ),
                                    )),
                                SizedBox(
                                    height: usableScreenWithoughtBars(context) *
                                        0.05),
                                Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: usableScreenWithoughtBars(
                                                  context) *
                                              0.01),
                                      decoration: profileBoxesDecoration,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                model.getUserVouchCount(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Raleway",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )
                                            ],
                                          ),
                                          Image.asset("assets/images/vouch.png")
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
                                        vertical:
                                            usableScreenWithoughtBars(context) *
                                                0.01),
                                    decoration: profileBoxesDecoration,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          "Aldeas",
                                          style: TextStyle(
                                              color: Color(0xffB1AFAF),
                                              fontFamily: "Raleway",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: usableScreenWithoughtBars(
                                                  context) *
                                              0.1,
                                          child: Image.asset(
                                              'assets/images/hoguera-azul.png'),
                                        ),
                                        Text(
                                          model.getUserCommunitiesCount(),
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
                                SizedBox(
                                    height: usableScreenWithoughtBars(context) *
                                        0.05),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            usableScreenWithoughtBars(context) *
                                                0.01),
                                    decoration: profileBoxesDecoration,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          "Wins",
                                          style: TextStyle(
                                              color: Color(0xffB1AFAF),
                                              fontFamily: "Raleway",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        SizedBox(height: usableScreenWithoughtBars(context) * 0.1, child: Image.asset('assets/images/win.png')),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              model.getUserWinsCount(),
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
                  )),
            ],
          )),
    );
  }
}
