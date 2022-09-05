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
