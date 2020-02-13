import 'package:flutter/material.dart';
import '../../ui/shared/ui_helpers.dart';

class NotchFiller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: notchHeight(context),
      color: Color(0xff17191E),
    );
  }
}
