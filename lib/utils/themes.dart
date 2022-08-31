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
      backgroundColor: const Color(0xffE5E5E5),
      brightness: Brightness.light,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: "Roboto",
            //height: 64,
            fontSize: 57,
            fontWeight: FontWeight.w400),
        displayMedium: TextStyle(
            fontFamily: "Roboto",
            //height: 52,
            fontSize: 45,
            fontWeight: FontWeight.w400),
        displaySmall: TextStyle(
            fontFamily: "Roboto",
            //height: 44,
            fontSize: 36,
            fontWeight: FontWeight.w400),
        headlineLarge: TextStyle(
          fontFamily: "Roboto",
          //height: 40,
          fontSize: 32,
          fontWeight: FontWeight.w400,
        ),
        headlineMedium: TextStyle(
          fontFamily: "Roboto",
          //: 36,
          fontSize: 28,
          fontWeight: FontWeight.w400,
        ),
        headlineSmall: TextStyle(
          fontFamily: "Roboto",
          //height: 32,
          fontSize: 24,
          fontWeight: FontWeight.w400,
        ),
        titleLarge: TextStyle(
          fontFamily: "Roboto",
          //height: 28,
          fontSize: 22,
          fontWeight: FontWeight.w400,
        ),
        titleMedium: TextStyle(
          fontFamily: "Roboto",
          //height: 24,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          fontFamily: "Roboto",
          //height: 20,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          fontFamily: "Roboto",
          height: 20,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontFamily: "Roboto",
          //height: 16,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          fontFamily: "Roboto",
          //height: 16,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          fontFamily: "Roboto",
          //height: 24,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          fontFamily: "Roboto",
          //height: 20,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        bodySmall: TextStyle(
          fontFamily: "Roboto",
          //height: 16,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff85E4F9))))));

// Login flow theme

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
  );
}
