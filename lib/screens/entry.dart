/*
  Entry page where Amplify is configured
 */

import 'dart:typed_data';

import 'package:amplify_api/amplify_api.dart';
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
  Future<bool> _configureAmplify() async {
    final auth = AmplifyAuthCognito();
    final analytics = AmplifyAnalyticsPinpoint();
    final api = AmplifyAPI();
    if (Amplify.isConfigured) {
      print('amplify already configured; no action');
      return true;
    }
    try {
      Amplify.addPlugins([auth, analytics, api]);
      await Amplify.configure(amplifyconfig);
      return true;
    } on AmplifyAlreadyConfiguredException {
      print('amplify already configured error');
      return true;
    } catch (e) {
      print('An error occurred while configuring Amplify: $e');
      return false;
    }
  }

  Future<bool> _onTestApi(bool ampConfig) async {
    if (!ampConfig) {
      print("Amplify config failed");
      return false;
    }
    /*
    try {
      final options = RestOptions(path: '/users');
      final restOperation = Amplify.API.post(restOptions: options);
      final response = await restOperation.response;
      print('GET call succeeded');
      print(String.fromCharCodes(response.data));
      return true;
    } on Exception catch (e) {
      print('GET call failed: $e');
      return false;
    }
    */
    try {
      final options = RestOptions(
          path: '/users',
          body: Uint8List.fromList('{\'name\':\'Mow the lawn\'}'.codeUnits));
      final restOperation = Amplify.API.post(restOptions: options);
      final response = await restOperation.response;
      print('POST call succeeded');
      print(String.fromCharCodes(response.data));
      return true;
    } on ApiException catch (e) {
      print('POST call failed: $e');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    context.read<Scale>().setHeightScale(height / mockupHeight);
    context.read<Scale>().setWidthScale(width / mockupWidth);
    return Scaffold(
        body: FutureBuilder(
      future: _configureAmplify().then((value) => _onTestApi(value)),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final success = snapshot.data!;
        if (success) {
          return const LoginScreen();
        } else {
          return Scaffold(backgroundColor: Colors.redAccent);
        }
      },
    ));
  }
}
