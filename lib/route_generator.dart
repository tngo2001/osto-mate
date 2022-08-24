import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:ostomate_app/screens/confirm.dart';
import 'package:ostomate_app/screens/confirm_reset.dart';
import 'package:ostomate_app/screens/dashboard.dart';
import 'package:ostomate_app/screens/entry.dart';
import 'package:ostomate_app/widgets/login.dart';
import 'main.dart';

// This class is where all route logic is handled when a route is pushed to the
// navigator.
class RouteGenerator {

  // Arguments for the new page are received in the settings variable
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {

      // The default landing page
      case '/':
        return MaterialPageRoute(builder: (_) => const EntryScreen());

      // Confirm verification code page
      case '/confirm':
        return PageRouteBuilder(
          pageBuilder: (_, __, ____) =>
              ConfirmScreen(data: args as Credentials),
          transitionsBuilder: (_, __, ____, child) => child,
        );

      // Confirm password reset page
      case '/confirm-reset':
        return PageRouteBuilder(
          pageBuilder: (_, __, ____) =>
              ConfirmResetScreen(data: args as Credentials),
          transitionsBuilder: (_, __, ____, child) => child,
        );

      // Dashboard page
      case '/dashboard':
        return PageRouteBuilder(
          pageBuilder: (_, __, ____) => const DashboardScreen(),
          transitionsBuilder: (_, __, ____, child) => child,
        );
      default:
        return _errorRoute();
    }
  }

  // "Error" page to indicate when there is a problem with the route pushed
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