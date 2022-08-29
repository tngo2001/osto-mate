/*
  Entry page where Amplify is configured
 */

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:ostomate_app/amplifyconfiguration.dart';
import 'package:ostomate_app/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:ostomate_app/providers/scale_provider.dart';
import 'package:ostomate_app/constants.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    if (!Amplify.isConfigured) {
      _configureAmplify();
    }
  }

  Future<void> _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();
    try {
      Amplify.addPlugins([auth, analytics]);
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print('An error occurred while configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<Scale>().setHeightScale(height / mockupHeight);
    context.read<Scale>().setWidthScale(width / mockupWidth);
    return Scaffold(
      body: _amplifyConfigured ? LoginScreen() : CircularProgressIndicator(),
    );
  }
}
