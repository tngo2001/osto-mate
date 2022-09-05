import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class SignupData {
  final String email;
  final String givenName;
  final String familyName;
  final String address;
  final String phone;
  final String birthdate;
  final String password;
  SignupData(
      {required this.email,
      required this.givenName,
      required this.address,
      required this.birthdate,
      required this.familyName,
      required this.password,
      required this.phone});
}

class Auth {
  Future<String?> signupUser(SignupData signupData) async {
    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: signupData.email,
        CognitoUserAttributeKey.phoneNumber: signupData.phone,
        CognitoUserAttributeKey.address: signupData.address,
        CognitoUserAttributeKey.familyName: signupData.familyName,
        CognitoUserAttributeKey.givenName: signupData.givenName,
        // additional attributes as needed
      };
      final result = await Amplify.Auth.signUp(
        username: signupData.email,
        password: signupData.password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      return null;
    } on AuthException catch (e) {
      return e.message;
    }
  }
}
