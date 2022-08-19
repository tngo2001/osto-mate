import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:ostomate_app/utils/validators.dart';

class Credentials {
  String name;
  String password;

  Credentials(this.name, this.password);
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  late Credentials _data;
  bool _isSignedIn = false;

  Future<String?> _onLogin(LoginData data) async {
    try {
      _data = Credentials(data.name, data.password);
      final res = await Amplify.Auth.signIn(
        username: data.name,
        password: data.password,
      );

      _isSignedIn = res.isSignedIn;
      return null;
    } on UserNotConfirmedException {
      return null;
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  Future<String?> _onSignup(SignupData data) async {
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
      _data = Credentials(data.name!, data.password!);
      return null;
    } on AuthException catch (e) {
      return '${e.message} Please try again.';
    }
  }

  Future<String?> _onRecoverPassword(String email) async {
    try {
      final res = await Amplify.Auth.resetPassword(username: email);

      return null;
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  Future<void> signOut() async {
    try {
      Amplify.Auth.signOut();
    } on AuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  final List<UserFormField> _additionalSignupFields = [
    UserFormField(
      keyName: "First Name",
      icon: const Icon(Icons.account_circle),
      fieldValidator: (value) => value != null ? null : "Please enter a value",
    ),
    UserFormField(
        keyName: "Last Name",
        icon: const Icon(Icons.account_circle),
        fieldValidator: (value) =>
            value != null ? null : "Please enter a value"),
    UserFormField(
        keyName: "Address",
        icon: const Icon(Icons.account_circle),
        fieldValidator: (value) =>
            value != null ? null : "Please enter a value"),
    UserFormField(
        keyName: "Phone Number",
        icon: const Icon(Icons.account_circle),
        fieldValidator: (value) {
          var phoneRegExp = phoneNumberRegex;
          if (value != null && !phoneRegExp.hasMatch(value)) {
            return "Must be in format \"+1 (XXX) XXX-XXXX\"";
          }
          if (value == null) {
            return "Please enter a value";
          }
          return null;
        })
  ];


  @override
  Widget build(BuildContext context) {
    signOut();
    return FlutterLogin(
      title: 'OSTO-MATE',
      theme: LoginTheme(
          primaryColor: Theme.of(context).primaryColor,
          accentColor: Theme.of(context).colorScheme.secondary,
          buttonTheme: LoginButtonTheme(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            highlightColor: Colors.lightBlue[700],
          ),
          bodyStyle: Theme.of(context).textTheme.bodyText1,
          titleStyle: Theme.of(context).textTheme.headline1,
          footerTextStyle: Theme.of(context).textTheme.bodyText1,
          buttonStyle: Theme.of(context).textTheme.bodyText1,
          switchAuthTextColor: Colors.black),
      onLogin: (LoginData data) => _onLogin(data),
      onRecoverPassword: (String email) => _onRecoverPassword(email),
      onSignup: (SignupData data) => _onSignup(data),
      additionalSignupFields: _additionalSignupFields,
      passwordValidator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a password.";
        }
        return isValidPassword(value);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed(
          _isSignedIn ? '/dashboard' : '/confirm',
          arguments: _data,
        );
      },
    );
  }
}
