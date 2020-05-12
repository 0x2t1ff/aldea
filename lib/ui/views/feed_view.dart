import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/ui/widgets/event_creation.dart';
import 'package:aldea/ui/widgets/feed_widget.dart';
import 'package:aldea/ui/widgets/finishedQuickstrike.dart';
import 'package:aldea/ui/widgets/post_item.dart';
import 'package:aldea/ui/widgets/quickstrike_item.dart';
import 'package:aldea/ui/widgets/startQuickstrike.dart';
import 'package:aldea/viewmodels/feed_view_model.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import "package:flutter/material.dart";
import 'package:provider_architecture/provider_architecture.dart';
import "../shared/app_colors.dart" as custcolor;

class FeedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<FeedViewModel>.withConsumer(
        viewModel: FeedViewModel(),
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
