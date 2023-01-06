import 'package:flutter/material.dart';
import 'package:ostomate_app/providers/scale_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Widget _longButton(
      double heightScale, double widthScale, Icon icon, String text) {
    return (GestureDetector(
        child: SizedBox(
      width: 324 * widthScale,
      height: 41 * heightScale,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
          child: Stack(children: [
            Align(child: icon, alignment: Alignment.centerLeft),
            Align(
              alignment: Alignment.center,
              child: Text(text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16)),
            )
          ]),
        ),
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    final widthScale = Provider.of<Scale>(context).widthScale;
    final heightScale = Provider.of<Scale>(context).heightScale;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Settings",
                style: TextStyle(
                    fontFamily: "Source Sans Pro",
                    fontWeight: FontWeight.w600,
                    fontSize: 40),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 16 * heightScale),
            _longButton(
                heightScale,
                widthScale,
                Icon(Icons.help_outline, size: 20 * heightScale),
                "Notifications"),
            SizedBox(height: 17 * heightScale),
            _longButton(heightScale, widthScale,
                Icon(Icons.key, size: 20 * heightScale), "Change password"),
            SizedBox(height: 17 * heightScale),
            _longButton(heightScale, widthScale,
                Icon(Icons.error_outline, size: 20 * heightScale), "About"),
          ],
        ),
      ),
    );
  }
}
