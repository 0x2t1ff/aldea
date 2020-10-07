import 'package:aldea/ui/widgets/create_user_post_widget.dart';
import 'package:aldea/ui/widgets/feed_widget.dart';
import 'package:aldea/ui/widgets/user_post_item.dart';
import 'package:aldea/viewmodels/user_post_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import 'package:aldea/models/community.dart';
import "../shared/app_colors.dart" as custcolor;
import "../shared/ui_helpers.dart" as devicesize;

class UserPostsView extends StatefulWidget {
  final Community community;
  const UserPostsView({this.community});

  @override
  _UserPostsViewState createState() => _UserPostsViewState();
}

class _UserPostsViewState extends State<UserPostsView> {
  bool isCreatingPost;
  var mod;
  void creatingPost() {
    setState(() {
      isCreatingPost = !isCreatingPost;
      print(isCreatingPost.toString());
    });
  }

  @override
  void initState() {
    isCreatingPost = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UserPostsViewModel>.reactive(
      viewModelBuilder: () => UserPostsViewModel(),
      onModelReady: (model) {
        model.fetchPosts(widget.community.uid);
        mod = widget.community.moderators.contains(model.currentUser.uid);
      },
      builder: (context, model, child) => Scaffold(
          backgroundColor: custcolor.darkGrey,
          body: Stack(
            children: <Widget>[
              model.posts != null
                  ? ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: model.posts.length,
                      itemBuilder: (context, index) => UserPostItem(
                        goToComments: () => model.goToComments(
                            model.posts[index].id,
                            model.posts[index].communityId),
                        uid: model.posts[index].userId,
                        navigate: () =>
                            model.navigate(model.posts[index].userId),
                        postModel: model.posts[index],
                        likeFunction: () => model.likeUserPost(
                            model.posts[index].id,
                            model.isLiked(model.posts[index].likes),
                            model.posts[index].likes,
                            widget.community.uid),
                        isLiked: model.isLiked(model.posts[index].likes),
                        isMod: mod,
                        deletePost: () => model.deletePost(
                            model.posts[index].id, widget.community.uid),
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                      ),
                    ),
              Positioned(
                bottom: devicesize.screenHeight(context) * 0.05,
                right: devicesize.screenWidth(context) * 0.1,
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: custcolor.blueTheme,
                  child: IconButton(
                    color: custcolor.almostBlack,
                    icon: Icon(Icons.local_post_office),
                    onPressed: () {
                      setState(() {
                        creatingPost();
                      });
                    },
                    iconSize: 40,
                  ),
                ),
              ),
              isCreatingPost
                  ? CreateUserPosts(
                      model: model,
                      func: () {
                        creatingPost();
                      },
                      communityId: widget.community.uid,
                    )
                  : Container()
            ],
          )),
    );
  }
}
