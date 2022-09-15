/*
  Contains theme data
 */

import 'package:control_style/decorated_input_border.dart';
import 'package:flutter/material.dart';

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
    snackBarTheme: const SnackBarThemeData(
        actionTextColor: Colors.white,
        backgroundColor: Color(0xff85E4F9),
        contentTextStyle: TextStyle(
          fontFamily: "Roboto",
          color: Colors.white,
          fontSize: 16,
        )),
    textButtonTheme: const TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStatePropertyAll(TextStyle(
                fontFamily: "Roboto",
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff85E4F9))))),
    inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        errorMaxLines: 2,
        labelStyle: TextStyle(
            color: Colors.grey.shade700, fontFamily: "Roboto", fontSize: 16),
        hintStyle: const TextStyle(
            color: Colors.grey, fontFamily: "Roboto", fontSize: 16),
        enabledBorder: DecoratedInputBorder(
          shadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
          child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
        focusedBorder: DecoratedInputBorder(
            isOutline: true,
            shadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Color(0xff85E4F9), style: BorderStyle.solid))),
        focusedErrorBorder: DecoratedInputBorder(
            isOutline: true,
            shadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.redAccent, style: BorderStyle.solid))),
        border: DecoratedInputBorder(
          isOutline: false,
          shadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
          child: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
        errorBorder: DecoratedInputBorder(
            isOutline: true,
            shadow: [BoxShadow(blurRadius: 4, color: Colors.grey)],
            child: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.redAccent, style: BorderStyle.solid)))),
  );

// Login flow theme

  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
  );
}
