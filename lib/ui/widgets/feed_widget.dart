import 'package:aldea/models/post_model.dart';
import 'package:aldea/ui/widgets/finishedQuickstrike.dart';
import 'package:aldea/ui/widgets/post_item.dart';
import 'package:aldea/ui/widgets/startQuickstrike.dart';
import 'package:flutter/material.dart';

class FeedWidget extends StatelessWidget {
  final PostModel postModel;
  const FeedWidget({this.postModel});
  @override
  Widget build(BuildContext context) {
    if (postModel.isAnnouncement == true) {
      print("announcement");
      return StartQuickstrike(postModel: postModel);
    } else if (postModel.isResult == true) {
      print("isresult");
      return FinishedQuickstrike(postModel: postModel);
    } else {
      print("isnormalpostXD");
      return PostItem(postModel: postModel);
    }

    return Container(
        child: Text("well that sucked" +
            "is announcement " +
            postModel.isAnnouncement.toString() +
            "   isResult " +
            postModel.isResult.toString() +
            postModel.title));
  }
}
