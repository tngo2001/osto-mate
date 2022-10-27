import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import '../utils/signup_data.dart';

class AuthService {
  static Future<void> loginUser(SignupData data, void Function() onSuccess,
      void Function(String) showError, void Function() unconfirmed) async {
    try {
      await Amplify.Auth.signIn(username: data.email, password: data.password);
      onSuccess.call();
    } on UserNotConfirmedException {
      unconfirmed.call();
    } on AuthException catch (e) {
      showError(e.message);
    }
  }

  static Future<void> signupUser(SignupData signupData,
      void Function() onSuccess, void Function(String) showError) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: signupData.email,
        CognitoUserAttributeKey.phoneNumber: signupData.phone!,
        CognitoUserAttributeKey.address: signupData.address!,
        CognitoUserAttributeKey.familyName: signupData.familyName!,
        CognitoUserAttributeKey.givenName: signupData.givenName!,
        CognitoUserAttributeKey.birthdate: signupData.birthdate!
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: signupData.email,
        password: signupData.password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      onSuccess.call();
    } on AuthException catch (e) {
      showError(e.message);
    }
  }

  // Make a call to Amplify to confirm signup
  static Future<void> verifyCode(SignupData data, String code,
      void Function() onSuccess, void Function(String) showError) async {
    try {
      final res = await Amplify.Auth.confirmSignUp(
        username: data.email,
        confirmationCode: code,
      );

      if (res.isSignUpComplete) {
        onSuccess.call();
      }
    } on CodeMismatchException catch (e) {
      showError(e.message);
    } on AuthException catch (e) {
      showError(e.message);
    }
  }

  // Callback if user requests a new code
  static Future<void> resendCode(SignupData data, void Function() onSuccess,
      void Function(String) showError) async {
    try {
      await Amplify.Auth.resendSignUpCode(username: data.email);
      onSuccess.call();
    } on AuthException catch (e) {
      showError(e.message);
    }
  }
  /*
  static Future<void> resetPassword() async {
    try {
      final result = Amplify.Auth.resetPassword
    }
  }
  */
}
