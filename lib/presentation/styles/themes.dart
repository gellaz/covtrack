import 'package:flutter/material.dart';

class Themes {
  static final ThemeData light = ThemeData(
    primarySwatch: Colors.deepOrange,
    accentColor: Colors.grey[850],
    accentColorBrightness: Brightness.dark,
    disabledColor: Colors.grey,
    canvasColor: Colors.white,
    buttonTheme: ButtonThemeData(
      height: 50,
      buttonColor: Colors.grey[850],
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    fontFamily: 'Prompt',
    textTheme: _textTheme,
  );

  static final ThemeData dark = ThemeData(
    primarySwatch: Colors.grey[850],
    accentColor: Colors.deepOrange,
    accentColorBrightness: Brightness.dark,
    disabledColor: Colors.grey,
    canvasColor: Colors.white,
    buttonTheme: ButtonThemeData(
      height: 50,
      buttonColor: Colors.deepOrange,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    fontFamily: 'Prompt',
    textTheme: _textTheme,
  );

  static const _textTheme = TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 96,
      letterSpacing: -1.5,
    ),
    headline2: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: 60,
      letterSpacing: -0.5,
    ),
    headline3: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 48,
      letterSpacing: 0,
    ),
    headline4: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 34,
      letterSpacing: 0.25,
    ),
    headline5: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      letterSpacing: 0,
    ),
    headline6: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20,
      letterSpacing: 0.15,
    ),
    subtitle1: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.15,
    ),
    subtitle2: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      letterSpacing: 0.1,
    ),
    bodyText1: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.5,
    ),
    bodyText2: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 0.25,
    ),
    button: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      letterSpacing: 1.25,
      color: Colors.white,
    ),
    caption: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      letterSpacing: 0.4,
    ),
    overline: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 10,
      letterSpacing: 1.5,
    ),
  );
}
