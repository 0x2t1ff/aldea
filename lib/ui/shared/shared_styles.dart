import 'package:flutter/material.dart';

// Box Decorations

BoxDecoration fieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[200]);

BoxDecoration disabledFieldDecortaion = BoxDecoration(
    borderRadius: BorderRadius.circular(5), color: Colors.grey[100]);

BoxDecoration profilePicDecoration = BoxDecoration(
    border: Border.all(
      color: Color(0xff0F1013),
      width: 4,
    ),
    borderRadius: BorderRadius.circular(100),
    boxShadow: [BoxShadow(offset: Offset(5, 5), blurRadius: 10)]);

BoxDecoration profileBoxesDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(19),
    color: Color(0xff17191E),
    boxShadow: [
      BoxShadow(offset: Offset(3, 3), blurRadius: 6, color: Colors.black),
    ]);

// Field Variables

const double fieldHeight = 55;
const double smallFieldHeight = 40;
const double inputFieldBottomMargin = 30;
const double inputFieldSmallBottomMargin = 0;
const EdgeInsets fieldPadding = const EdgeInsets.symmetric(horizontal: 15);
const EdgeInsets largeFieldPadding =
    const EdgeInsets.symmetric(horizontal: 15, vertical: 15);

// Text Variables
const TextStyle buttonTitleTextStyle =
    const TextStyle(fontWeight: FontWeight.w700, color: Colors.white);
