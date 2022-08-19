import 'package:flutter/material.dart';

ThemeData ostomateTheme = ThemeData(
    primaryColor: Colors.grey[100],
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
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: Colors.lightBlue[200]));

