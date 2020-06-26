import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/ui/widgets/quickstrike_item.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import "package:flutter/material.dart";
import 'package:stacked/stacked.dart';
import "../shared/app_colors.dart" as custcolor;

class QuickSTrikeView extends StatelessWidget {
  final QuickStrikePost emptyQuickstrike = new QuickStrikePost(
    isEmpty: true,
  );
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuickStrikeViewModel>.reactive(
        viewModelBuilder: () => QuickStrikeViewModel(),
        onModelReady: (model) => model.fetchPosts(),
        createNewModelOnInsert: true,
        builder: (context, model, child) => Scaffold(
            body: !model.busy
                ? Container(
                    child: model.posts.length >= 8
                        ? ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: model.posts.length,
                            itemBuilder: (context, index) => QuickStrikeItem(
                              quickStrikePost: model.posts[index],
                              index: index,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.all(0),
                            itemCount: 8,
                            itemBuilder: (context, index) =>
                                model.posts.length > index
                                    ? QuickStrikeItem(
                                        quickStrikePost: model.posts[index],
                                        index: index,
                                        model: model,
                                      )
                                    : QuickStrikeItem(
                                        index: index,
                                        quickStrikePost: emptyQuickstrike,
                                        model: model,
                                      ),
                          ))
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                    ),
                  )));
  }
}
