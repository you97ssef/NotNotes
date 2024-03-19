import 'package:flutter/material.dart';

class AppWidgets {
  static const SizedBox gap = SizedBox(height: 16, width: 16);
  static const SizedBox mediumGap = SizedBox(height: 8, width: 8);
  static const SizedBox smallGap = SizedBox(height: 4, width: 4);

  static const EdgeInsets padding = EdgeInsets.all(16);
  static const EdgeInsets mediumPadding = EdgeInsets.all(8);
  static const EdgeInsets smallPadding = EdgeInsets.all(4);

  static const Widget loading = Center(child: CircularProgressIndicator());

  static const BorderRadius primaryBorderRadius = BorderRadius.all(Radius.circular(16));
}
