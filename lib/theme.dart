import 'package:flutter/material.dart';

ThemeData lrThemeData = ThemeData(
  // primarySwatch: Colors.lightGreen,
  // accentColor: Colors.greenAccent,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.lightGreen,
    // primaryColorDark: Colors.black,
    accentColor: Colors.grey,
    backgroundColor: Colors.amber,
    errorColor: Colors.red,
    brightness: Brightness.light,
  ),
  buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
);
