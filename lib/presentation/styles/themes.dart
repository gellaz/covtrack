import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData light = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.deepOrange,
      textTheme: textTheme(Colors.white),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    iconTheme: IconThemeData(color: Colors.grey[850]),
    primarySwatch: Colors.deepOrange,
    primaryColor: Colors.deepOrange,
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
    textTheme: textTheme(Colors.grey[850]),
    primaryTextTheme: textTheme(Colors.grey[850]),
    accentTextTheme: textTheme(Colors.grey[850]),
  );

  static final ThemeData dark = ThemeData(
    appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(),
      actionsIconTheme: IconThemeData(
        color: Colors.deepOrange,
      ),
    ),
    cardColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.deepOrange),
    primarySwatch: Colors.grey,
    primaryColor: Colors.grey[850],
    primaryColorBrightness: Brightness.light,
    accentColor: Colors.deepOrange,
    accentColorBrightness: Brightness.dark,
    disabledColor: Colors.grey,
    canvasColor: Colors.grey[850],
    buttonTheme: ButtonThemeData(
      height: 50,
      buttonColor: Colors.deepOrange,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    fontFamily: 'Prompt',
    textTheme: textTheme(Colors.deepOrange),
    primaryTextTheme: textTheme(Colors.deepOrange),
    accentTextTheme: textTheme(Colors.deepOrange),
  );

  static TextTheme textTheme(Color textColor) {
    return TextTheme(
      headline1: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w300,
        fontSize: 96,
        letterSpacing: -1.5,
      ),
      headline2: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w300,
        fontSize: 60,
        letterSpacing: -0.5,
      ),
      headline3: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 48,
        letterSpacing: 0,
      ),
      headline4: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 34,
        letterSpacing: 0.25,
      ),
      headline5: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 24,
        letterSpacing: 0,
      ),
      headline6: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 20,
        letterSpacing: 0.15,
      ),
      subtitle1: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        letterSpacing: 0.15,
      ),
      subtitle2: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.1,
      ),
      bodyText1: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
      bodyText2: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 0.25,
      ),
      button: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 14,
        letterSpacing: 1.25,
      ),
      caption: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
      overline: TextStyle(
        color: textColor,
        fontWeight: FontWeight.w400,
        fontSize: 10,
        letterSpacing: 1.5,
      ),
    );
  }
}
