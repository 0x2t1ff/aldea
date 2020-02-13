import 'package:flutter/material.dart';
import '../../ui/shared/ui_helpers.dart';

class BottomFiller extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: bottomHeight(context),
      color: Color(0xff17191E),
    );
  }
}