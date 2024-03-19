import 'package:flutter/material.dart';
import 'package:not_notes/config/functions/app_functions.dart';
import 'package:not_notes/config/app.dart';

void main() async {
  await AppFunctions.initialize();

  runApp(const App());
}
