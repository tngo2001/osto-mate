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
  int _selectedIndex = 0;

  // WIP; need to create navbar
  @override
  Widget build(BuildContext context) {
    TextStyle optionStyle = Theme.of(context).textTheme.bodyMedium!;
    List<Widget> _widgetOptions = <Widget>[
      Text('Index 0: Home', style: optionStyle),
      Text('Index 1: Scan', style: optionStyle),
      Text('Index 2: Help', style: optionStyle),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text("Welcome, John"),
        elevation: 0,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Hello'),
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
