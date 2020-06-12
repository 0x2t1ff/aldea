import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/widgets/community_creation_request_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:aldea/viewmodels/admin_screen_view_model.dart';

class AdminScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AdminScreenViewModel>.reactive(
      viewModelBuilder: () => AdminScreenViewModel(),
      onModelReady: (model) => model.getAdminRequests(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: darkGrey,
          body: model.requests != null
              ? ListView.builder(
                  itemCount: model.requests.length,
                  itemBuilder: (context, index) {
                    return CommunityCreationWidget(model.requests[index],() => model.seeRequest(model.requests[index]));
                  })
              : Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    blueishGreyColor,
                  ),
                ))),
    );
  }
}
