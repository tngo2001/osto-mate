import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ostomate_app/providers/scale_provider.dart';
import 'package:ostomate_app/utils/input_field_info.dart';
import 'package:provider/provider.dart';
import 'package:ostomate_app/widgets/custom_text_form_field.dart';
import 'package:ostomate_app/utils/validators.dart';
import 'dart:collection';
import 'package:ostomate_app/utils/signup_input_fields.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final Map<String, TextEditingController> _nameControllers;

  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameControllers = HashMap<String, TextEditingController>.fromIterable(
        inputFields,
        key: (formFields) => formFields.keyName,
        value: (formFields) => TextEditingController());
    for (var value in _nameControllers.values) {
      value.addListener(() {});
    }
  }

  @override
  void dispose() {
    _nameControllers.forEach((key, value) {
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

  Widget _buildFields(double heightScale) {
    return Column(
        children: inputFields.map((InputFieldInfo info) {
      return CustomTextFormField(
        controller: _nameControllers[info.keyName]!,
        hintText: info.hintText,
        hintTextStyle: Theme.of(context).textTheme.bodyLarge!,
        heightScale: heightScale,
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
      //FocusScope.of(context).requestFocus(FocusNode());
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
                              _buildFields(heightScale),
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
