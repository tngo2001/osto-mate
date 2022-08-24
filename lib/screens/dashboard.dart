/*
  Represents the user dashboard upon signin.
 */

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  late AuthUser _user;

  @override
  void initState() {
    Amplify.Auth.getCurrentUser().then((user) {
      setState(() {
        _user = user;
      });
    }).catchError((e) {
      print(e.message);
    });
    super.initState();
  }

  // WIP; need to create navbar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Hello'),
          Text(_user.username),
          Text(_user.userId),
        ]),
      ),
      /*
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBar(items: items)
        ],
      ),

       */
    );
  }
}
