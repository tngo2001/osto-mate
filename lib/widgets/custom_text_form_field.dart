import 'package:control_style/decorated_input_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.inputFormatters,
      this.validator,
      this.inputType,
      this.hintTextStyle,
      required this.heightScale,
      required this.widthScale,
      this.onChanged})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextStyle? hintTextStyle;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final double heightScale;
  final double widthScale;
  final void Function(String?)? onChanged;

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
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(height: 0.5),
                  helperText: ' ',
                  helperStyle: const TextStyle(height: 0.5),
                  isDense: false,
                  labelText: hintText,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                ),
              ),
            ),
            const SizedBox(height: 8)
          ]);
    });
  }
}
