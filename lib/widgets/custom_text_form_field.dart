import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.inputFormatters,
    this.validator,
    this.inputType,
    required this.hintTextStyle,
    required this.heightScale,
    this.onChanged,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextStyle hintTextStyle;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final double heightScale;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Material(
          shadowColor: Colors.grey,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            validator: validator,
            keyboardType: inputType,
            style: hintTextStyle,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              labelText: hintText,
              labelStyle: hintTextStyle,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
              //fillColor: Colors.white,
              //filled: true,
              contentPadding:
                  const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            ),
          ),
        ),
        SizedBox(height: 10 * heightScale),
      ],
    );
  }
}
