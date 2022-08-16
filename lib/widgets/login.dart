import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future<String> _onLogin(BuildContext context, LoginData data) async {
    return '';
  }

  Future<String?> _onSignup(BuildContext context, SignupData data) async {
    try {
      await Amplify.Auth.signUp(
        username: data.name!,
        password: data.password!,
        options: CognitoSignUpOptions(userAttributes: {
          CognitoUserAttributeKey.email: data.name!,
          CognitoUserAttributeKey.address:
              data.additionalSignupData!["Address"]!,
          CognitoUserAttributeKey.givenName:
              data.additionalSignupData!["First Name"]!,
          CognitoUserAttributeKey.phoneNumber: data
              .additionalSignupData!["Phone Number"]!
              .replaceAll(RegExp(r'[^0-9+]'), ''),
          CognitoUserAttributeKey.familyName:
              data.additionalSignupData!["Last Name"]!,
        }),
      );
      return null;
    } on AuthException catch (e) {
      return '${e.message} Please try again.';
    }
  }

  String? isValidPassword(String pass) {
    final meetsLength = RegExp(r'^[A-Za-z\d@$!%*#?&_[\]{}]{8,}$');
    final hasNumber = RegExp(r'^(?=.*\d)[A-Za-z\d@$!%*#?&_[\]{}]{8,}$');
    final hasUpperLower =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*#?&_[\]{}]{8,}$');
    final hasSymbol = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&_[\]{}])[A-Za-z\d@$!%*#?&_[\]{}]{8,}$');
    if (pass.contains(" ")) {
      return "Password cannot contain spaces";
    }
    if (!meetsLength.hasMatch(pass)) {
      return "Password must be at least 8 characters long";
    }
    if (!hasNumber.hasMatch(pass)) {
      return "Password must contain a number";
    }
    if (!hasUpperLower.hasMatch(pass)) {
      return "Must contain an uppercase and lowercase character";
    }
    if (!hasSymbol.hasMatch(pass)) {
      return "Password must contain a symbol";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Ostomate',
      onLogin: (LoginData data) => _onLogin(context, data),
      onRecoverPassword: (_) => Future.value(''),
      onSignup: (SignupData data) => _onSignup(context, data),
      additionalSignupFields: [
        UserFormField(
          keyName: "First Name",
          icon: Icon(Icons.account_circle),
          fieldValidator: (value) =>
              value != null ? null : "Please enter a value",
        ),
        UserFormField(
            keyName: "Last Name",
            icon: Icon(Icons.account_circle),
            fieldValidator: (value) =>
                value != null ? null : "Please enter a value"),
        UserFormField(
            keyName: "Address",
            icon: Icon(Icons.account_circle),
            fieldValidator: (value) =>
                value != null ? null : "Please enter a value"),
        UserFormField(
            keyName: "Phone Number",
            icon: Icon(Icons.account_circle),
            fieldValidator: (value) {
              var phoneRegExp = RegExp(
                  r'^[\+][0-9]{1,2}[\s]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4}$');
              if (value != null && !phoneRegExp.hasMatch(value)) {
                return "Must be in format \"+1 (XXX) XXX-XXXX\"";
              }
              if (value == null) {
                return "Please enter a value";
              }
              return null;
            })
      ],
      passwordValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a password.";
        }
        return isValidPassword(value);
      },
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
      ),
      onSubmitAnimationCompleted: () {},
    );
  }
}
