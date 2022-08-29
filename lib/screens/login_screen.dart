import 'package:flutter/material.dart';
import 'package:ostomate_app/providers/scale_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePasswordInput = true;

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 4 * Provider.of<Scale>(context).heightScale),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black,
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: Theme.of(context).textTheme.bodySmall,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 4 * Provider.of<Scale>(context).heightScale),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black,
            child: TextFormField(
              obscureText: _obscurePasswordInput,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePasswordInput = !_obscurePasswordInput;
                    });
                  },
                  child: Icon(_obscurePasswordInput
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                suffixIconColor: const Color(0xff979797),
                labelText: "Password",
                labelStyle: Theme.of(context).textTheme.bodySmall,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final widthScale = Provider.of<Scale>(context).widthScale;
    final heightScale = Provider.of<Scale>(context).heightScale;
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Theme.of(context).backgroundColor,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: SafeArea(
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                        horizontal: 50.0 * widthScale,
                        vertical: 150.0 * heightScale),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/ostomate-logo.png",
                          scale: widthScale,
                        ),
                        SizedBox(
                          height: 9 * heightScale,
                        ),
                        Text(
                          "WELCOME TO",
                          style: TextStyle(
                              color: const Color(0xffff4647),
                              fontFamily: "Bebas Neue",
                              fontSize: 24 * widthScale),
                        ),
                        Text(
                          "OSTO-MATE",
                          style: TextStyle(
                              color: const Color(0xffff4647),
                              fontFamily: "Bebas Neue",
                              fontSize: 56 * widthScale),
                        ),
                        SizedBox(height: 20 * heightScale),
                        _buildEmailTF(),
                        SizedBox(height: 20),
                        _buildPasswordTF()
                      ],
                    ))),
          )
        ],
      ),
    ));
  }
}
