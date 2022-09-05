import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ostomate_app/widgets/password_form_field.dart';

class PasswordForm extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmController;
  final TextStyle? hintTextStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?) validator;
  final double heightScale;
  final double widthScale;
  final void Function(String?)? onChanged;
  final bool obscurePassword;
  final void Function() onTap;
  const PasswordForm(
      {Key? key,
      required this.passwordController,
      required this.confirmController,
      this.hintTextStyle,
      this.inputFormatters,
      required this.validator,
      required this.heightScale,
      required this.widthScale,
      this.onChanged,
      required this.obscurePassword,
      required this.onTap})
      : super(key: key);

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PasswordFormField(
          controller: widget.passwordController,
          heightScale: widget.heightScale,
          widthScale: widget.widthScale,
          obscurePassword: widget.obscurePassword,
          onTap: widget.onTap,
          validator: widget.validator,
        ),
        const SizedBox(height: 8),
        PasswordFormField(
          controller: widget.confirmController,
          heightScale: widget.heightScale,
          hintText: "Confirm Password",
          widthScale: widget.widthScale,
          obscurePassword: widget.obscurePassword,
          onTap: widget.onTap,
          validator: (pass) {
            if (pass == null || pass.isEmpty) {
              return "Please confirm your password";
            } else if (pass != widget.passwordController.text) {
              return "Passwords do not match";
            }
            return null;
          },
        ),
      ],
    );
  }
}
