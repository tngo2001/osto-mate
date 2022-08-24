/*
  Contains theme data
 */

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

// Text styles
class TextStyles {
  static const TextStyle heading1 = TextStyle(
      fontFamily: "Bebas Neue",
      fontWeight: FontWeight.w400,
      fontSize: 56,
      color: Color(0xffFF4647));
  static const TextStyle body1 = TextStyle(
      fontFamily: "Roboto",
      fontWeight: FontWeight.w400,
      fontSize: 15,
      color: Colors.black);
}

class Themes {

// MaterialApp theme
  static ThemeData ostomateTheme = ThemeData(
      primaryColor: const Color(0xffE5E5E5),
      fontFamily: 'Roboto',
      textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 66.0,
            color: Colors.red[400],
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto Condensed',
            //height: 79,
          ),
          headline2: const TextStyle(
            fontSize: 54,
            color: Colors.black,
            //height: 63
          ),
          bodyText1: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            //height: 21
          ),
          bodyText2: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            //height: 21
          )),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.lightBlue[200]));

// Login flow theme
  static LoginTheme loginTheme = LoginTheme(
    primaryColor: const Color(0xffE5E5E5),
    accentColor: const Color(0xff85E4F9),
    buttonTheme: const LoginButtonTheme(
      backgroundColor: Color(0xff85E4F9),
      highlightColor: Color(0xff85daf9),
    ),
    bodyStyle: TextStyles.body1,
    titleStyle: TextStyles.heading1,
    buttonStyle: TextStyles.body1,
    switchAuthTextColor: Colors.black,
    headerMargin: 40.0,
    cardTopPosition: 400,
    inputTheme: inputDecorationTheme
  );

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
  );
}
