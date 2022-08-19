import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:ostomate_app/screens/confirm.dart';
import 'screens/entry.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSTO-MATE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
          headline2: TextStyle(
            fontSize: 54,
            color: Colors.black,
           //height: 63
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: Colors.black,
           //height: 21
          )
        )
      ),
      onGenerateRoute: (settings) {
        if(settings.name == '/confirm') {
          return PageRouteBuilder(pageBuilder: (_, __, ____) =>
              ConfirmScreen(data: settings.arguments as SignupData),
            transitionsBuilder: (_, __, ____, child) => child,
          );
        }
        return MaterialPageRoute(builder: (_) => EntryScreen());
      }
    );
  }
}