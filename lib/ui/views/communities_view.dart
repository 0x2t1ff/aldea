import 'dart:math';

import 'package:aldea/ui/widgets/all_communities.dart';
import 'package:aldea/ui/widgets/communities_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import '../../viewmodels/communities_view_model.dart';
import '../../ui/shared/ui_helpers.dart';

class CommunitiesView extends StatefulWidget {
  @override
  _CommunitiesViewState createState() => _CommunitiesViewState();
}

class _CommunitiesViewState extends State<CommunitiesView>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  var isShowingMore = false;

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CommunitiesViewModel>.withConsumer(
      viewModel: CommunitiesViewModel(),
      onModelReady: (model) {
        if (model.topCommunities.isEmpty) {
          model.fetchCommunities();
        }
      },
      builder: (context, model, child) => model.isShowingMore
          ? AllCommunities(model: model)
          : Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: usableScreenHeight(context) * 0.8,
                  padding: EdgeInsets.only(left: 15, top: 20, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    color: Color(0xff3C8FA7),
                                  ),
                                  horizontalSpaceSmall,
                                  Text(
                                    "Top de la semana",
                                    style: TextStyle(
                                        color: Color(0xffb5b5b5), fontSize: 29),
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: CommunitiesCarousel(
                                busy: model.busy,
                                url1: model.busy
                                    ? null
                                    : model.topCommunities[0]['picUrl'],
                                url2: model.busy
                                    ? null
                                    : model.topCommunities[1]['picUrl'],
                                url3: model.busy
                                    ? null
                                    : model.topCommunities[2]['picUrl'],
                              )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text("Comunidades",
                                      style: TextStyle(
                                        color: Color(0xffb5b5b5),
                                        fontSize: 29,
                                      )),
                                  GestureDetector(
                                    onTap: () => model.showAllCommunities(),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 14),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xff223C47),
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Más",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          SizedBox(width: 5),
                                          Transform(
                                            alignment: Alignment.center,
                                            transform: Matrix4.rotationY(pi),
                                            child: Icon(
                                              Icons.reply,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical:
                                            usableScreenWithoughtBars(context) *
                                                0.05),
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: GridView.count(
                                      padding: EdgeInsets.all(0),
                                      physics: NeverScrollableScrollPhysics(),
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      crossAxisCount: 3,
                                      children: <Widget>[
                                        ...model.communitiesList.map((c) =>
                                            GestureDetector(
                                              onTap: () => model
                                                  .showAllCommunities(c: c),
                                              child: Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(14),
                                                    color: Color(0xff223C47),
                                                    image: c.bkdPicUrl != null
                                                        ? DecorationImage(
                                                            image: NetworkImage(
                                                                c.iconPicUrl),
                                                            fit: BoxFit.cover,
                                                            colorFilter:
                                                                ColorFilter.mode(
                                                                    Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.1),
                                                                    BlendMode
                                                                        .srcOver))
                                                        : null),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color(0xff223C47)
                                                          .withOpacity(0.6),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(14),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          14))),
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  child: Text(
                                                    c.name,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ))
                                      ],
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
