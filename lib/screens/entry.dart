import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:ostomate_app/amplifyconfiguration.dart';
import '../widgets/login.dart';


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
    return Scaffold(
        body: !Amplify.isConfigured ? FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if(snapshot.hasError) {
                return Center (
                  child: Text(
                    '${snapshot.error} occurred while attempting to configure Amplify',
                    style: const TextStyle(fontSize: 18),
                  )
                );
              }
              else {
                return const Login();
              }
            }
            return const Center(
                child: CircularProgressIndicator()
            );
          },
          future: _configureAmplify(),
        )
            : const Login());
  }
}
