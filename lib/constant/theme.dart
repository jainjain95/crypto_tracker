import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  // ignore: prefer_const_constructors
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.white,
  ),
  iconTheme: IconThemeData(
    color: Colors.black,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Color(0xff1516a),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: Color(0xff1516a),
  ),
);