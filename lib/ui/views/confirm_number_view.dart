import 'package:flutter/services.dart';

import '../shared/ui_helpers.dart';
import '../widgets/busy_button.dart';
import '../widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../viewmodels/confirm_view_model.dart';
import 'package:international_phone_input/international_phone_input.dart';

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
              InternationalPhoneInput(
                onPhoneNumberChange:
                    (number, internationalizedPhoneNumber, isoCode) =>
                        model.onPhoneNumberChange(
                            number, internationalizedPhoneNumber, isoCode),
                enabledCountries: ["ES"],
                showCountryCodes: true,
                showCountryFlags: true,
              ),
              verticalSpaceSmall,
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeIn,
                height: model.isCodeSent ? null : 0,
                child: InputField(
                  placeholder: 'Codigo de verificacion',
                  controller: passwordController,
                ),
              ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BusyButton(
                      title: 'Enviar codigo',
                      onPressed: () => model.createPhoneAuth(context))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
