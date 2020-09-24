import 'package:flutter/services.dart';

import '../shared/ui_helpers.dart';
import '../widgets/busy_button.dart';
import '../widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/confirm_view_model.dart';

class ConfirmNumberView extends StatelessWidget {
  final numberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmNumberViewModel>.reactive(
      viewModelBuilder: () => ConfirmNumberViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Añade tu telefono',
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
              verticalSpaceLarge,
              InputField(
                placeholder: 'P.E. +34 66666666',
                controller: numberController,
                textInputType: TextInputType.phone,
              ),
              verticalSpaceSmall,
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                child: InputField(
                  placeholder: 'Código de verificación',
                  controller: passwordController,
                ),
              ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BusyButton(
                    title: 'Enviar código',
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
