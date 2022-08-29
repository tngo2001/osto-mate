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
      colorScheme: const ColorScheme(
        background: Color(0xffE5E5E5),
        onBackground: Color(0xff2f2f2f),
        brightness: Brightness.light,
        error: Colors.redAccent,
        onError: Colors.white,
        primary: Color(0xff85E4F9),
        onPrimary: Color(0xff2f2f2f),
        surface: Colors.white,
        onSurface: Color(0xff000000),
        secondary: Color(0xff85E4F9),
        onSecondary: Color(0xff2f2f2f),
      ),
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      brightness: Brightness.light,
      textTheme: const TextTheme(
          bodySmall: TextStyle(
              fontFamily: "Roboto",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              color: Color(0xff2f2f2f))));

// Login flow theme

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
  );
}
