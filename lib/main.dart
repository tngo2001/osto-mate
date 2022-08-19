import 'package:flutter/material.dart';
import 'package:ostomate_app/route_generator.dart';
import 'package:ostomate_app/utils/themes.dart';

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
        theme: ostomateTheme,
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
