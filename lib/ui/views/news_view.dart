import 'package:aldea/ui/widgets/feed_widget.dart';
import 'package:aldea/viewmodels/news_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import 'package:aldea/models/community.dart';
import "../shared/app_colors.dart" as custcolor;


class NewsView extends StatelessWidget {
  final Community community;
  const NewsView({ this.community});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsViewModel>.reactive(
      viewModelBuilder: () => NewsViewModel(),
      onModelReady: (model) => model.fetchPosts(community.uid),
      builder: (context, model, child) => Scaffold(
        backgroundColor: custcolor.darkGrey,
        body:
            model.posts != null
                ? 
                     ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: model.posts.length,
                      itemBuilder: (context, index) => FeedWidget(
                        
                        navigateToComments: () => model
                                        .goToComments(model.posts[index].id),
                        navigateToCommunity: () =>
                                        model.communityFromFeed(
                                            model.posts[index].communityId),
                          postModel: model.posts[index],
                          likeFunction: () => model.likePost(
                              model.posts[index].id,
                              model.isLiked(model.posts[index].likes),
                              model.posts[index].likes),
                          isLiked: model.isLiked(model.posts[index].likes, 
                          ),
                          deleteAllowed: community.moderators.contains(model.currentUser.uid),),
                    )
                  
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                    ),
                  ),
          
        
      ),
    );
  }
}
