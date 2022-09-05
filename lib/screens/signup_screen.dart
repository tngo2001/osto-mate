import 'package:flutter/material.dart';
import 'package:ostomate_app/providers/scale_provider.dart';
import 'package:ostomate_app/utils/input_field_info.dart';
import 'package:ostomate_app/utils/validators.dart';
import 'package:ostomate_app/widgets/password_form_field.dart';
import 'package:provider/provider.dart';
import 'package:ostomate_app/widgets/custom_text_form_field.dart';
import 'dart:collection';
import 'package:ostomate_app/utils/signup_input_fields.dart';
import '../widgets/password_form.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final Map<String, TextEditingController> _fieldControllers;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _fieldControllers = HashMap<String, TextEditingController>.fromIterable(
        inputFields,
        key: (formFields) => formFields.keyName,
        value: (formFields) => TextEditingController());
    for (var value in _fieldControllers.values) {
      value.addListener(() {});
    }
  }

  @override
  void dispose() {
    _fieldControllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  Widget _buildSubmitButton(String label, void Function() onPressed) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Theme.of(context).colorScheme.primary;
      }
      return Theme.of(context).colorScheme.primary;
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          minimumSize: MaterialStatePropertyAll(
              Size(110 * Provider.of<Scale>(context).widthScale, 32))),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildFields(double heightScale, double widthScale) {
    return Column(
        children: inputFields.map((InputFieldInfo info) {
      return CustomTextFormField(
        controller: _fieldControllers[info.keyName]!,
        hintText: info.hintText,
        hintTextStyle: Theme.of(context).textTheme.bodyLarge!,
        heightScale: heightScale,
        widthScale: widthScale,
        inputFormatters: info.inputFormatters,
        validator: info.validator,
        inputType: info.inputType,
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final widthScale = Provider.of<Scale>(context).widthScale;
    final heightScale = Provider.of<Scale>(context).heightScale;

    void _submit() {
      FocusScope.of(context).requestFocus(FocusNode());
      if (!formKey.currentState!.validate()) {
        return;
      }
      formKey.currentState!.save();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          actions: [
            TextButton(
              style: Theme.of(context).textButtonTheme.style,
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Login"),
            )
          ],
        ),
        body: GestureDetector(
          //onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                color: Theme.of(context).backgroundColor,
              ),
              SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: SafeArea(
                    child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                            horizontal: 50.0 * widthScale,
                            vertical: 20.0 * heightScale),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _buildFields(heightScale, widthScale),
                              PasswordForm(
                                passwordController: _passwordController,
                                confirmController: _confirmPasswordController,
                                heightScale: heightScale,
                                widthScale: widthScale,
                                obscurePassword: _obscurePassword,
                                validator: (pass) =>
                                    Validators.isValidPassword(pass),
                                onTap: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              _buildSubmitButton("Submit", _submit),
                            ],
                          ),
                        ))),
              )
            ],
          ),
        ));
  }
}
