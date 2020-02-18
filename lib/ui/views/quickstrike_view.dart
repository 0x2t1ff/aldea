import 'package:aldea/ui/widgets/quickstrike_item.dart';
import 'package:aldea/viewmodels/quickstrike_view_model.dart';
import "package:flutter/material.dart";
import '../shared/ui_helpers.dart';
import 'package:provider_architecture/provider_architecture.dart';
import "../shared/app_colors.dart" as custcolor;

class QuickSTrikeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<QuickStrikeViewModel>.withConsumer(
      viewModel: QuickStrikeViewModel(),
      onModelReady: (model) => model.fetchPosts(),
      builder: (context, model, child) => 
         model.posts != null
              ?  ListView.builder(
                padding: EdgeInsets.all(0),
                    itemCount: model.posts.length,
                    itemBuilder: (context, index) => QuickStrikeItem(
                      quickStrikePost: model.posts[index],
                    ),
                  )
                
              : Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(custcolor.blueishGreyColor),
                  ),
                ),
      
          
      
    );
  }
}
