/*
  Contains the logic for validating signin/signup inputs
 */
class Validators {
  static String? isValidPassword(String? pass) {
    // Password must be at least 8 characters
    final meetsLength = RegExp(r'^[A-Za-z\d@$()!%*#?&_[\]{}]{8,}$');

    // Password must contain a number
    final hasNumber = RegExp(r'^(?=.*\d)[A-Za-z\d@$()!%*#?&_[\]{}]{8,}$');

    final hasUpperLower = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!()%*#?&_[\]{}]{8,}$');

    // Valid symbols currently include '@$!%*#?&_[]{}'
    final hasSymbol = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[()@$!%*#?&_[\]{}])[A-Za-z\d@$!%*()#?&_[\]{}]{8,}$');
    if (pass == null || pass.isEmpty) {
      return "Please enter a password.";
    }
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

  static String? isValidConfirmCode(String? code) {
    if (code == null || code.isEmpty) {
      return "Can't be empty";
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(code)) {
      return "Code must contain only numbers";
    }
    if (code.length != 6) {
      return "Code must be 6 digits long";
    }
    return null;
  }

  static String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return "Cannot be empty";
    } else if (!emailRegex.hasMatch(email)) {
      return "Please enter a valid email address";
    }
    return null;
  }

  static String? isValidPhone(String? phoneNumber) {
    if (phoneNumber == null) {
      return "Please enter a value";
    }
    if (!phoneRegex.hasMatch(phoneNumber)) {
      return "Must be in format \"+1 (XXX) XXX-XXXX\"";
    }
    return null;
  }

  static String? isNotNull(String? input) {
    if (input == null || input.isEmpty) {
      return "Cannot be empty";
    }
    return null;
  }

  static final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  static final phoneRegex = RegExp(
      r'^[\+][0-9]{1,2}[\s]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4}$');
}
