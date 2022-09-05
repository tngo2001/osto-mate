import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      keyName: "address",
      hintText: "Address",
      validator: (address) {
        return Validators.isNotNull(address);
      },
      inputType: TextInputType.streetAddress),
  InputFieldInfo(
      keyName: "phone",
      hintText: "Phone",
      validator: (phone) {
        return Validators.isValidPhone(phone);
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9+\-()]'))
      ],
      inputType: TextInputType.phone),
  InputFieldInfo(
      keyName: "birthdate",
      hintText: "Birthdate",
      validator: (date) {
        return Validators.isNotNull(date);
      },
      inputType: TextInputType.datetime)
];
