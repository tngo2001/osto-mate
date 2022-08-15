import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:ostomate_app/amplifyconfiguration.dart';

class EntryScreen extends StatefulWidget {
  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();
    try {
      await Amplify.addPlugins([auth, analytics]);
      await Amplify.configure(amplifyconfig);
    } catch(e) {
      print('An error occurred while configuring Amplify: $e');
    }
    setState(() {
      _amplifyConfigured: true;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_amplifyConfigured ? 'Configured' : 'Not configured'),
      ),
    );
  }
}
