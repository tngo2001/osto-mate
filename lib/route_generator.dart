import 'package:flutter/material.dart';
import 'package:ostomate_app/screens/confirm.dart';
import 'package:ostomate_app/screens/dash/dashboard.dart';
import 'package:ostomate_app/screens/dash/settings.dart';
import 'package:ostomate_app/screens/entry.dart';
import 'package:ostomate_app/screens/auth/signup_screen.dart';
import 'package:ostomate_app/utils/signup_data.dart';

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

      // Dashboard page
      case '/dashboard':
        return PageRouteBuilder(
          pageBuilder: (_, __, ____) => const DashboardScreen(),
          transitionsBuilder: (_, __, ____, child) => child,
        );

      // Signup page
      case '/signup':
        return PageRouteBuilder(
            pageBuilder: (_, __, ____) => const SignupScreen(),
            transitionsBuilder: (_, __, ____, child) => child);
      // Confirm account page
      case '/confirm':
        return PageRouteBuilder(
            pageBuilder: (_, __, ____) =>
                ConfirmScreen(data: args as SignupData),
            transitionsBuilder: (_, __, ____, child) => child);
      case '/settings':
        return PageRouteBuilder(
            pageBuilder: (_, __, ____) => SettingsScreen(),
            transitionsBuilder: (_, __, ____, child) => child);

      default:
        return _errorRoute();
    }
  }

  // "Error" page to indicate when there is a problem with the route pushed
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
      );
    });
  }
}
