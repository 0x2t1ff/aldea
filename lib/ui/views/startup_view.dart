import 'package:aldea/ui/shared/app_colors.dart';
import 'package:aldea/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/startup_view_model.dart';

class 
StartUpView extends StatelessWidget {
  const StartUpView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartUpViewModel>.reactive(
        viewModelBuilder: () => StartUpViewModel(),
        onModelReady: (model) => model.handleStartUpLogic(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: loginColor,
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        width: screenWidth(context) * 0.45,
                        height: screenHeight(context) * 0.45,
                        child: Image.asset('assets/images/hoguera.png')),
                      SizedBox(height:40),
                    CircularProgressIndicator(
                      
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(blueTheme))
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ));
  }
}
