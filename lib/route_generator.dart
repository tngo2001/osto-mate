import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:ostomate_app/screens/confirm.dart';
import 'package:ostomate_app/screens/confirm_reset.dart';
import 'package:ostomate_app/screens/dashboard.dart';
import 'package:ostomate_app/screens/entry.dart';
import 'package:ostomate_app/widgets/login.dart';
import 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const EntryScreen());
      case '/confirm':
        return PageRouteBuilder(
          pageBuilder: (_, __, ____) =>
              ConfirmScreen(data: settings.arguments as Credentials),
          transitionsBuilder: (_, __, ____, child) => child,
        );
      case '/confirm-reset':
        return PageRouteBuilder(
          pageBuilder: (_, __, ____) =>
              ConfirmResetScreen(data: settings.arguments as Credentials),
          transitionsBuilder: (_, __, ____, child) => child,
        );
      case '/dashboard':
        return PageRouteBuilder(
          pageBuilder: (_, __, ____) => const DashboardScreen(),
          transitionsBuilder: (_, __, ____, child) => child,
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error')
        ),
      );
    });
  }
}