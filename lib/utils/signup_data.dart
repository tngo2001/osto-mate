class SignupData {
  final String email;
  final String? givenName;
  final String? familyName;
  final String? address;
  final String? phone;
  final String? birthdate;
  final String password;
  SignupData(
      {required this.email,
      this.givenName,
      this.address,
      this.birthdate,
      this.familyName,
      required this.password,
      this.phone});
}
