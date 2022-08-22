import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:ostomate_app/utils/validators.dart';
import '../widgets/login.dart';

class ConfirmResetScreen extends StatefulWidget {
  final Credentials data;

  const ConfirmResetScreen({Key? key, required this.data}) : super(key: key);

  @override
  ConfirmResetScreenState createState() => ConfirmResetScreenState();
}

class ConfirmResetScreenState extends State<ConfirmResetScreen> {
  final _confirmCodeController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEnabled = false;
  bool _obscureText = true;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _confirmCodeController.addListener(() {
      setState(() {
        _isEnabled = _confirmCodeController.text.isNotEmpty;
      });
    });
    _newPasswordController.addListener(() {
      setState(() {
        _isEnabled = _newPasswordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _confirmCodeController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword(Credentials data, String code,
      String password, VoidCallback onSuccess) async {
    try {
      await Amplify.Auth.confirmResetPassword(
          username: data.name,
          confirmationCode: code,
          newPassword: password
      );
      onSuccess.call();
    } on CodeMismatchException catch (e) {
      _showNotif(context, e.message, Colors.redAccent);
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
          style: Theme
              .of(context)
              .textTheme
              .bodyText2,
        ),
      ),
    );
  }

  void _submit() {
    setState(() {
      _submitted = true;
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _resetPassword(widget.data, _confirmCodeController.text,
          _newPasswordController.text, () {
            _showNotif(
                context, "Password reset successfully!",
                Colors.blueAccent);
            Navigator.pushReplacementNamed(
                context, '/');
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
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
                        TextFormField(
                          controller: _confirmCodeController,
                          autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                          decoration: const InputDecoration(
                            filled: true,
                            contentPadding:
                            EdgeInsets.symmetric(vertical: 4.0),
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Enter confirmation code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(40)),
                            ),
                          ),
                          validator: (text) {
                            return isValidConfirmCode(text);
                          }
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          autovalidateMode: _submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                          controller: _newPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            filled: true,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 4.0),
                            prefixIcon: const Icon(Icons.lock),
                            labelText: 'Enter new password',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(40)),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off
                              ),
                            ),
                          ),
                          validator: (text) {
                            return isValidPassword(text);
                          },
                        ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          onPressed: _isEnabled
                              ? () {
                            _submit();
                          }
                              : null,
                          elevation: 4,
                          disabledColor: Theme
                              .of(context)
                              .colorScheme
                              .secondary,
                          color: Colors.lightBlue[500],
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            'RESET',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
