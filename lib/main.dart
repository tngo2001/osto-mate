// Main to start app

import 'package:flutter/material.dart';
import 'package:ostomate_app/providers/scale_provider.dart';
import 'package:ostomate_app/route_generator.dart';
import 'package:ostomate_app/utils/themes.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() {
  runApp(MultiProvider(
      providers: [Provider(create: (context) => Scale())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSTO-MATE',
      debugShowCheckedModeBanner: false,
      theme: Themes.ostomateTheme,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
