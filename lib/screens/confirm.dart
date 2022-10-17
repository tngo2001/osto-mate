/*
  Generates the page to confirm account with verification code
 */

import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:ostomate_app/api/api_service.dart';
import 'package:ostomate_app/utils/snackbars.dart';
import 'package:ostomate_app/utils/validators.dart';
import 'package:ostomate_app/widgets/custom_text_form_field.dart';
import '../utils/signup_data.dart';
import 'package:provider/provider.dart';
import 'package:ostomate_app/providers/scale_provider.dart';

class ConfirmScreen extends StatefulWidget {
  final SignupData data;

  const ConfirmScreen({Key? key, required this.data}) : super(key: key);

  @override
  ConfirmScreenState createState() => ConfirmScreenState();
}

class ConfirmScreenState extends State<ConfirmScreen> {
  final _controller = TextEditingController();
  bool _isEnabled = false;
  bool _resendCodeTapped = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildResendCode() {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () {
          AuthService.resendCode(widget.data, () {
            Snackbars.showSuccessSnackbar(context, "Code resent!");
          }, (s) {
            Snackbars.showErrorSnackbar(context, s);
          });
        },
        onTapDown: (down) {
          setState(() {
            _resendCodeTapped = true;
          });
        },
        onTapUp: (up) {
          setState(() {
            _resendCodeTapped = false;
          });
        },
        child: Text(
          "Resend Code",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: "Roboto",
              fontSize: 16,
              decoration: _resendCodeTapped
                  ? TextDecoration.underline
                  : TextDecoration.none),
        ),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    final widthScale = Provider.of<Scale>(context).widthScale;
    final heightScale = Provider.of<Scale>(context).heightScale;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Verify"),
          titleTextStyle: Theme.of(context).textTheme.headlineSmall,
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomTextFormField(
                          controller: _controller,
                          hintText: "Enter confirmation code",
                          validator: (code) =>
                              Validators.isValidConfirmCode(code),
                          heightScale: heightScale,
                          widthScale: widthScale),
                      _buildSubmitButton(
                        "Submit",
                        () => AuthService.verifyCode(
                            widget.data, _controller.text, () {
                          Navigator.of(context)
                              .pushReplacementNamed("/dashboard");
                        }, (message) {
                          Snackbars.showErrorSnackbar(context, message);
                        }),
                      ),
                      _buildResendCode()
                    ],
                  ),
                )),
              )
            ],
          ),
        ));
  }
}
