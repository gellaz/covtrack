import 'package:flutter/material.dart';

class Themes {
  static final ThemeData light = ThemeData(
    primarySwatch: Colors.deepOrange,
    accentColor: Colors.grey[850],
    canvasColor: Colors.white,
    fontFamily: 'Prompt',
    textTheme: TextTheme(
      display4: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 106,
        letterSpacing: -1.5,
      ),
      display3: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 66,
        letterSpacing: -0.5,
      ),
      display2: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 53,
        letterSpacing: 0,
      ),
      display1: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 38,
        letterSpacing: 0.25,
      ),
      headline: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 27,
        letterSpacing: 0,
      ),
      title: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        letterSpacing: 0.15,
      ),
      subhead: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 18,
        letterSpacing: 0.15,
      ),
      body2: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 0.1,
      ),
      body1: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        letterSpacing: 0.5,
      ),
      caption: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: 0.25,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 1.25,
      ),
      subtitle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        letterSpacing: 0.4,
      ),
      overline: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        letterSpacing: 1.5,
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Colors.yellow,
    canvasColor: Colors.white,
    fontFamily: 'Prompt',
    textTheme: TextTheme(
      display4: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 106,
        letterSpacing: -1.5,
      ),
      display3: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 66,
        letterSpacing: -0.5,
      ),
      display2: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 53,
        letterSpacing: 0,
      ),
      display1: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 38,
        letterSpacing: 0.25,
      ),
      headline: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 27,
        letterSpacing: 0,
      ),
      title: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        letterSpacing: 0.15,
      ),
      subhead: TextStyle(
        fontWeight: FontWeight.w300,
        fontSize: 18,
        letterSpacing: 0.15,
      ),
      body2: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 0.1,
      ),
      body1: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 18,
        letterSpacing: 0.5,
      ),
      caption: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        letterSpacing: 0.25,
      ),
      button: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        letterSpacing: 1.25,
      ),
      subtitle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 13,
        letterSpacing: 0.4,
      ),
      overline: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 11,
        letterSpacing: 1.5,
      ),
    ),
  );
}
