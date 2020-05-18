import 'package:aldea/ui/widgets/feed_widget.dart';
import 'package:aldea/viewmodels/feed_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
        viewModelBuilder: () => FeedViewModel(),
        onModelReady: (model) => model.fetchPosts(),
        builder: (context, model, child) => Scaffold(
            body:

                //    backgroundColor: Colors.red,
                //  )
                model.posts != null
                    ? ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: model.posts.length,
                        itemBuilder: (context, index) => FeedWidget(
                          postModel:model.posts[index],
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              custcolor.blueishGreyColor),
                        ),
                      )));
  }
}
