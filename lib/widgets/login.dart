/*
  This widget is the login flow
 */
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:ostomate_app/utils/validators.dart';

import '../utils/themes.dart';

// Credentials object to allow passing username (email) and password to other
// pages
class Credentials {
  String name;
  String password;

  Credentials(this.name, this.password);
}

// The Login widget to handle signin and signup
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}


class LoginState extends State<Login> {
  late Credentials _data;
  bool _isSignedIn = false;

  // Login callback when user submits signin information
  Future<String?> _onLogin(LoginData data) async {
    try {
      _data = Credentials(data.name, data.password);

      // Call to Amplify to attempt signin
      final res = await Amplify.Auth.signIn(
        username: data.name,
        password: data.password,
      );
      _isSignedIn = res.isSignedIn;
      return null;
    }

    // This catch currently does nothing, but represents the case when a user
    // attempts signin but their account has not been confirmed.
    // Because _isSignedIn will be false in this case, they are redirected
    // to the confirmation page.
    on UserNotConfirmedException {
      return null;
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }
  }

  // Signup callback when user submits signup info
  Future<String?> _onSignup(SignupData data) async {
    try {

      // Call to Amplify to attempt signup
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

  // Callback for when password recovery info is submitted
  Future<String?> _onRecoverPassword(String email,
      VoidCallback onSuccess) async {
    try {
      final res = await Amplify.Auth.resetPassword(username: email);

      //print(res);
      if (res.nextStep.updateStep == "CONFIRM_RESET_PASSWORD_WITH_CODE") {
        onSuccess.call();
      }
      return null;
    } on AuthException catch (e) {
      return '${e.message} - ${e.recoverySuggestion}';
    }

  }

  // Call to Amplify to signout a user
  Future<void> signOut() async {
    try {
      Amplify.Auth.signOut();
    } on AuthException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
    }
  }

  // Constant variable to store additional signup fields
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
          var phoneRegExp = Validators.phoneNumberRegex;
          if (value != null && !phoneRegExp.hasMatch(value)) {
            return "Must be in format \"+1 (XXX) XXX-XXXX\"";
          }
          if (value == null) {
            return "Please enter a value";
          }
          return null;
        })
  ];

  // Customizing some of the text in the login flow
  final LoginMessages _loginMessages = LoginMessages(
    additionalSignUpFormDescription: "Please provide the following information",
    recoverPasswordDescription: "A verification code will be sent to this email.",
    recoverPasswordIntro: "Reset Password"
  );

  @override
  Widget build(BuildContext context) {

    // Currently, the app signs out the user every time they close and reopen it
    // This is for testing but might also be appropriate as a security feature.
    signOut();
    return FlutterLogin(
      title: 'OSTO-MATE',
      theme: Themes.loginTheme,
      logo: const AssetImage('assets/ostomate-logo.png'),
      onLogin: (LoginData data) => _onLogin(data),
      onRecoverPassword: (String email) {
        _onRecoverPassword(email, () {
          Navigator.of(context).pushReplacementNamed(
              '/confirm-reset',
              arguments: Credentials(email, ''));
        });
      },
      onSignup: (SignupData data) => _onSignup(data),
      additionalSignupFields: _additionalSignupFields,
      passwordValidator: (value) {
        return Validators.isValidPassword(value);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed(
          _isSignedIn ? '/dashboard' : '/confirm',
          arguments: _data,
        );
      },
      messages: _loginMessages,
    );
  }
}
