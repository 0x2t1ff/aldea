import 'package:aldea/models/post_model.dart';
import 'package:aldea/ui/widgets/finishedQuickstrike.dart';
import 'package:aldea/ui/widgets/post_item.dart';
import 'package:aldea/ui/widgets/startQuickstrike.dart';
import 'package:flutter/material.dart';

class FeedWidget extends StatelessWidget {
  final PostModel postModel;
  final Function likeFunction;
  final bool isLiked;
  final Function navigateToComments;
  final Function navigateToCommunity;
  final bool deleteAllowed;
  final Function deletePost;
  const FeedWidget(
      {this.postModel,
      this.likeFunction,
      this.isLiked,
      this.navigateToComments,
      this.navigateToCommunity, 
      this.deleteAllowed,
      this.deletePost});
  @override
  Widget build(BuildContext context) {
    if (postModel.isAnnouncement == true) {
      return StartQuickstrike(
        goToComments: navigateToComments,
        postModel: postModel,
        likeFunction: likeFunction,
        isLiked: isLiked,
        goToCommunity: navigateToCommunity,
        deleteAllowed: deleteAllowed,
        deletePost: deletePost
        ,
      );
    } else if (postModel.isResult == true) {
      return FinishedQuickstrike(
        postModel: postModel,
        likeFunction: likeFunction,
        isLiked: isLiked,
        navigateToComments: navigateToComments,
        goToCommunity: navigateToCommunity,
        allowedDelete: deleteAllowed,
        deletePost: deletePost,

      );
    } else {
      return PostItem(
        likeFunction: likeFunction,
        postModel: postModel,
        isLiked: isLiked,
        navigateToComments: navigateToComments,
        goToCommunity: navigateToCommunity,
        allowedDelete: deleteAllowed,
        deletePost: deletePost,
      );
    }
  }
}
