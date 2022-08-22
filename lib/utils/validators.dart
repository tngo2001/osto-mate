
String? isValidPassword(String? pass) {
  final meetsLength = RegExp(r'^[A-Za-z\d@$!%*#?&_[\]{}]{8,}$');
  final hasNumber = RegExp(r'^(?=.*\d)[A-Za-z\d@$!%*#?&_[\]{}]{8,}$');
  final hasUpperLower =
  RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[A-Za-z\d@$!%*#?&_[\]{}]{8,}$');
  final hasSymbol = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&_[\]{}])[A-Za-z\d@$!%*#?&_[\]{}]{8,}$');
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

String? isValidConfirmCode(String? code) {
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

final phoneNumberRegex = RegExp(
    r'^[\+][0-9]{1,2}[\s]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4}$');