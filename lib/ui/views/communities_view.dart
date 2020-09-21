import 'dart:ui';

import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/widgets/all_communities.dart';
import 'package:aldea/ui/widgets/communities_carousel.dart';
import 'package:aldea/ui/widgets/community_preview.dart';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/communities_view_model.dart';
import '../../ui/shared/ui_helpers.dart';

class CommunitiesView extends StatefulWidget {
  @override
  _CommunitiesViewState createState() => _CommunitiesViewState();
}

class _CommunitiesViewState extends State<CommunitiesView>
    with AutomaticKeepAliveClientMixin {
  ScrollController controller = ScrollController();

  @override
  bool get wantKeepAlive => true;
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return ViewModelBuilder<CommunitiesViewModel>.reactive(
      viewModelBuilder: () => CommunitiesViewModel(),
      onModelReady: (model) {
        model.fetchCommunities();
        controller.addListener(() {
          if (controller.position.pixels /
                      controller.position.maxScrollExtent >=
                  0.6 &&
              model.isLoadingMore == false) {
            model.loadMoreCommunities();
          }
        });
      },
      builder: (context, model, child) => WillPopScope(
        onWillPop: model.onWillPop,
        child: Stack(children: <Widget>[
          SingleChildScrollView(
            controller: controller,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 20, top: 20, right: 20),
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
                          Padding(
                            padding:  EdgeInsets.only(left:screenWidth(context) * 0.14),
                            child: IconButton(
                              icon: Icon(Icons.refresh, color: blueTheme,size: 35),
                              onPressed: () => model.fetchCommunities(),
                            ),
                          )
                        ],
                      ),
                      CommunitiesCarousel(
                        busy: model.busy,
                        url1: model.busy ? null : model.topCommunities[0],
                        url2: model.busy ? null : model.topCommunities[1],
                        url3: model.busy ? null : model.topCommunities[2],
                        model: model,
                      ),
                      AllCommunities(
                        model: model,
                        selectCommunity: model.selectCommunity,
                        unselectCommunity: model.unselectCommunity,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              GestureDetector(
                onTap: model.unselectCommunity,
                child: Container(
                    width: screenWidth(context) * model.height,
                    height: screenHeight(context) * model.height,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.white.withOpacity(0.1),
                        width: screenWidth(context),
                        height: screenHeight(context),
                      ),
                    )),
              ),
              Center(
                child: CommunityPreview(
                  community: model.selectedCommunity != null
                      ? model.selectedCommunity
                      : null,
                  cancel: model.unselectCommunity,
                  model: model,
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
