/*
  Generates the page to confirm account with verification code
 */

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ostomate_app/api/api_service.dart';
import 'package:ostomate_app/utils/snackbars.dart';
import '../utils/signup_data.dart';

class ConfirmScreen extends StatefulWidget {
  final SignupData data;

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
                          contentPadding: EdgeInsets.symmetric(vertical: 4.0),
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
                                AuthService.verifyCode(
                                    widget.data, _controller.text, () {
                                  Navigator.pushReplacementNamed(
                                      context, '/dashboard');
                                }, (message) {
                                  Snackbars.showErrorSnackbar(context, message);
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
                          AuthService.resendCode(widget.data, () {
                            Snackbars.showSuccessSnackbar(
                                context, "Confirmation code has been resent.");
                          }, (message) {
                            Snackbars.showErrorSnackbar(context, message);
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
