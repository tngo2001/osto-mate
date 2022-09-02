import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordFormField extends StatelessWidget {
  const PasswordFormField(
      {Key? key,
      required this.controller,
      this.inputFormatters,
      this.validator,
      this.inputType,
      required this.hintTextStyle,
      required this.heightScale,
      required this.widthScale,
      required this.obscurePassword,
      required this.onTap,
      this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final TextStyle hintTextStyle;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final double heightScale;
  final double widthScale;
  final void Function(String?)? onChanged;
  final bool obscurePassword;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 287 * widthScale,
              child: TextFormField(
                validator: validator,
                keyboardType: inputType,
                style: hintTextStyle,
                controller: controller,
                obscureText: obscurePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                      onTap: onTap,
                      child: Icon(
                          obscurePassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey.shade700)),
                  labelText: "Password",
                  errorStyle: (TextStyle(height: 1)),
                  helperText: ' ',
                  helperStyle: TextStyle(height: 1),
                  isDense: false,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                ),
              ),
            )
          ]);
    });
  }
}
