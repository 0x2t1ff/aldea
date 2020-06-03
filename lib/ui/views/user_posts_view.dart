import 'package:aldea/ui/widgets/feed_widget.dart';
import 'package:aldea/ui/widgets/user_post_item.dart';
import 'package:aldea/viewmodels/user_post_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import 'package:aldea/models/community.dart';
import "../shared/app_colors.dart" as custcolor;


class UserPostsView extends StatelessWidget {
  final Community community;
  const UserPostsView({ this.community});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserPostsViewModel>.reactive(
      viewModelBuilder: () => UserPostsViewModel(),
      onModelReady: (model) => model.fetchPosts(community.uid),
      builder: (context, model, child) => Scaffold(
        backgroundColor: custcolor.darkGrey,
        body:
            model.posts != null
                ? 
                     ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: model.posts.length,
                      itemBuilder: (context, index) => UserPostItem(
                          postModel: model.posts[index],
                          likeFunction: () => model.likePost(
                              model.posts[index].id,
                              model.isLiked(model.posts[index].likes),
                              model.posts[index].likes),
                          isLiked: model.isLiked(model.posts[index].likes)),
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
