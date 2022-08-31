import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldInfo {
  final String keyName;
  final String hintText;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  const InputFieldInfo(
      {required this.keyName,
      required this.hintText,
      this.inputType,
      this.inputFormatters,
      this.validator});
}
