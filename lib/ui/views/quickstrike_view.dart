import 'package:aldea/ui/widgets/quickstrike_item.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class QuickSTrikeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuickStrikeViewModel>.reactive(
        viewModelBuilder: () => QuickStrikeViewModel(),
        onModelReady: (model) => model.fetchPosts(),
        builder: (context, model, child) => Scaffold(
            body:

                //    backgroundColor: Colors.red,
                //  )
                model.posts != null
                    ? ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: model.posts.length,
                        itemBuilder: (context, index) => QuickStrikeItem(
                          quickStrikePost: model.posts[index],
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
