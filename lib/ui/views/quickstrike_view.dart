import 'package:aldea/models/quickstrike_model.dart';
import 'package:aldea/ui/widgets/quickstrike_item.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import "package:flutter/material.dart";
import 'package:rxdart/rxdart.dart';
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
        builder: (context, model, child) => Scaffold(
            body: !model.busy
                ? Container(
                    child: StreamBuilder(
                      stream: model.posts,
                      builder: (context, data) {
                        if (data.hasData == false) {
                          return Text(
                            'No Data...',
                          );
                        } else if (data.hasError) {
                          return Text(data.error.toString());
                        } else if (data.data == null) {
                          return Center(child: Text("data is null"));
                        } else {
                          print(data);
                         DocumentSnapshot docSnapshot = data.data;
                         print(docSnapshot.data);
                         Map<dynamic, dynamic> quickstrikeMaps =
                             docSnapshot.data;
                         List quickstrikesList =
                             quickstrikeMaps.values.toList();

                         return ListView.builder(
                             itemCount: quickstrikesList.length,
                             itemBuilder: (context, index) {
                               print(quickstrikesList.toString());
                               var quickModel =
                                   QuickStrikePost.fromMap(quickstrikeMaps);
                               return QuickStrikeItem(
                                   model: model,
                                   quickStrikePost: quickModel,
                                   index: index);
                             });
                        }
                      },
                    ),
                  )

                //     child: model.posts.length >= 8
                //         ? ListView.builder(
                //             padding: EdgeInsets.all(0),
                //             itemCount: model.posts.length,
                //             itemBuilder: (context, index) => QuickStrikeItem(
                //               quickStrikePost: model.posts[index],
                //               index: index,
                //             ),
                //           )
                //         : ListView.builder(
                //             padding: EdgeInsets.all(0),
                //             itemCount: 8,
                //             itemBuilder: (context, index) =>
                //                 model.posts.length > index
                //                     ? QuickStrikeItem(
                //                         quickStrikePost: model.posts[index],
                //                         index: index,
                //                         model: model,
                //                       )
                //                     : QuickStrikeItem(
                //                         index: index,
                //                         quickStrikePost: emptyQuickstrike,
                //                         model: model,
                //                       ),
                //           ))
                : Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                    ),
                  )));
  }
}
