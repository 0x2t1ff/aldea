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
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                        width: 300,
                        height: 100,
                        child: Image.asset('assets/images/hoguera.png')),
                      SizedBox(height:40),
                    CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(Colors.red))
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
              ),
            ));
  }
}
