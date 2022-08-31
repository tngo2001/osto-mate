import 'package:flutter/material.dart';

import 'input_field_info.dart';
import 'validators.dart';

final List<InputFieldInfo> inputFields = [
  InputFieldInfo(
      keyName: "email",
      hintText: "Email",
      inputType: TextInputType.emailAddress,
      validator: (email) {
        return Validators.isValidEmail(email);
      }),
  InputFieldInfo(
      keyName: "givenName",
      hintText: "Given name",
      validator: (name) {
        return Validators.isNotNull(name);
      }),
  InputFieldInfo(
      keyName: "familyName",
      hintText: "Family Name",
      validator: (name) {
        return Validators.isNotNull(name);
      }),
  InputFieldInfo(
      keyName: "Address",
      hintText: "Address",
      validator: (address) {
        return Validators.isNotNull(address);
      }),
];
