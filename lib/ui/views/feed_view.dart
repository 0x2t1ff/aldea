import 'package:aldea/ui/widgets/feed_widget.dart';
import 'package:aldea/viewmodels/feed_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;
import "../shared/ui_helpers.dart" as devicesize;

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
      viewModelBuilder: () => FeedViewModel(),
      onModelReady: (model) => model.fetchPosts(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: custcolor.darkGrey,
        body: Column(
          children: <Widget>[
            model.communityList != null
                ? Container(
                    color: custcolor.darkGrey,
                    width: devicesize.screenWidth(context),
                    height: devicesize.screenHeight(context) * 0.12,
                    child: Align(
                      child: Container(
                        height: devicesize.screenHeight(context) * 0.085,
                        child: ListView.builder(
                            padding: EdgeInsets.only(
                                left: devicesize.screenWidth(context) * 0.02),
                            scrollDirection: Axis.horizontal,
                            itemCount: model.communityList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () => model.goToCommunity(
                                      model.communityList[index]),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              devicesize.screenWidth(context) *
                                                  0.018),
                                      height: devicesize.screenHeight(context) *
                                          0.055,
                                      child: ClipOval(
                                        child: Image.network(
                                          model.communityList[index].iconPicUrl,
                                          fit: BoxFit.fill,
                                        ),
                                      )));
                            }),
                      ),
                    ),
                  )
                : Container(),
            model.posts != null
                ? Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: model.posts.length,
                      itemBuilder: (context, index) => FeedWidget(
                          postModel: model.posts[index],
                          likeFunction: () => model.likePost(
                              model.posts[index].id,
                              model.isLiked(model.posts[index].likes),
                              model.posts[index].likes),
                          isLiked: model.isLiked(model.posts[index].likes)),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
