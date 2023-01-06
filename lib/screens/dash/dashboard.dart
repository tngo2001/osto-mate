/*
  Represents the user dashboard upon signin.
 */

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/scale_provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  Widget _cardButton(BuildContext context, double heightScale,
      double widthScale, Icon icon, String text, String routeName) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(routeName);
      },
      behavior: HitTestBehavior.deferToChild,
      child: SizedBox(
        width: 317 * widthScale,
        height: 86 * heightScale,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                border: Border.all(
                    width: 1.0, color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(4)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(children: [
                icon,
                SizedBox(width: 20 * widthScale),
                Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _homeCard(BuildContext context, double heightScale, double widthScale,
      String title, List<Widget> cardButtons) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: 357 * widthScale,
                height: 225 * heightScale,
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 24,
                          fontFamily: "Source Sans Pro",
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(height: 10 * heightScale),
                  ...cardButtons
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle optionStyle = Theme.of(context).textTheme.bodyMedium!;
    final widthScale = Provider.of<Scale>(context).widthScale;
    final heightScale = Provider.of<Scale>(context).heightScale;
    List<Widget> _cardButtons1 = <Widget>[
      _cardButton(context, heightScale, widthScale,
          Icon(Icons.shopping_cart, size: 40), "Make a Purchase", "/"),
      SizedBox(height: 10 * heightScale),
      _cardButton(context, heightScale, widthScale,
          Icon(Icons.history, size: 40), "My Scan History", "/")
    ];
    List<Widget> _cardButtons2 = <Widget>[
      _cardButton(context, heightScale, widthScale,
          Icon(Icons.feedback_outlined, size: 40), "Feedback", "/"),
      SizedBox(height: 10 * heightScale),
      _cardButton(context, heightScale, widthScale,
          Icon(Icons.settings_outlined, size: 40), "Settings", "/settings")
    ];

    List<Widget> _widgetOptions = <Widget>[
      Column(
        children: [
          _homeCard(
              context, heightScale, widthScale, "Your Stoma", _cardButtons1),
          _homeCard(context, heightScale, widthScale, "Support", _cardButtons2),
        ],
      ),
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
        title: const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 21,
              ),
              child: Text(
                "Welcome, John",
                style: TextStyle(
                    fontFamily: "Source Sans Pro",
                    fontWeight: FontWeight.w600,
                    fontSize: 40),
                textAlign: TextAlign.left,
              ),
            )),
        elevation: 0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex != 0 ? Icons.home_outlined : Icons.home,
                  size: 25),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: (Icon(
                _selectedIndex != 1
                    ? Icons.photo_camera_outlined
                    : Icons.photo_camera,
                size: 25,
              )),
              label: 'Scan'),
          BottomNavigationBarItem(
              icon: (Icon(_selectedIndex != 2 ? Icons.help_outline : Icons.help,
                  size: 25)),
              label: 'Help'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
