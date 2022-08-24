/*
  Generates the page to confirm account with verification code
 */

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../widgets/login.dart';

class ConfirmScreen extends StatefulWidget {
  final Credentials data;

  const ConfirmScreen({Key? key, required this.data}) : super(key: key);

  @override
  ConfirmScreenState createState() => ConfirmScreenState();
}

class ConfirmScreenState extends State<ConfirmScreen> {
  final _controller = TextEditingController();
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Callback to make a call to Amplify to confirm signup
  Future<void> _verifyCode(BuildContext context, Credentials data, String code,
      VoidCallback onSuccess) async {
    try {
      final res = await Amplify.Auth.confirmSignUp(
        username: data.name,
        confirmationCode: code,
      );

      if (res.isSignUpComplete) {
        // Login user
        final user = await Amplify.Auth.signIn(
            username: data.name, password: data.password);

        if (user.isSignedIn) {
          onSuccess.call();
        }
      }
    } on CodeMismatchException catch (e) {
      _showNotif(context, e.message, Colors.redAccent);
    } on AuthException catch (e) {
      _showNotif(context, e.message, Colors.redAccent);
    }
  }

  // Callback if user requests a new code
  Future<void> _resendCode(
      BuildContext context, Credentials data, VoidCallback onSuccess) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: data.name);
      onSuccess.call();
    } on AuthException catch (e) {
      _showNotif(context, e.message, Colors.redAccent);
    }
  }

  void _showNotif(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Card(
                elevation: 12,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: const EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          filled: true,
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 4.0),
                          prefixIcon: Icon(Icons.lock),
                          labelText: 'Enter confirmation code',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      MaterialButton(
                        onPressed: _isEnabled
                            ? () {
                                _verifyCode(
                                    context, widget.data, _controller.text, () {
                                  Navigator.pushReplacementNamed(
                                      context, '/dashboard');
                                });
                              }
                            : null,
                        elevation: 4,
                        disabledColor: Theme.of(context).colorScheme.secondary,
                        color: Colors.lightBlue[500],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: const Text(
                          'VERIFY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          _resendCode(context, widget.data, () {
                            _showNotif(
                                context,
                                "Confirmation code has been resent.",
                                Colors.blueAccent);
                          });
                        },
                        child: const Text(
                          'Resend code',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
