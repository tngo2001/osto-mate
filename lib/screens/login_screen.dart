import 'package:flutter/material.dart';
import 'package:ostomate_app/providers/scale_provider.dart';
import 'package:ostomate_app/utils/validators.dart';
import 'package:ostomate_app/widgets/password_form_field.dart';
import 'package:provider/provider.dart';
import 'package:ostomate_app/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePasswordInput = true;
  bool _forgotPasswordTapped = false;
  bool _loginButtonEnabled = false;
  bool _signUpTapped = false;
  final _email = TextEditingController();
  final _password = TextEditingController();

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black,
            child: TextFormField(
              obscureText: _obscurePasswordInput,
              style: Theme.of(context).textTheme.bodyLarge,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePasswordInput = !_obscurePasswordInput;
                    });
                  },
                  child: Icon(_obscurePasswordInput
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                suffixIconColor: const Color(0xff979797),
                labelText: "Password",
                labelStyle: Theme.of(context).textTheme.bodyLarge,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none),
                fillColor: Colors.white,
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTapDown: (down) {
          setState(() {
            _forgotPasswordTapped = true;
          });
        },
        onTapUp: (up) {
          setState(() {
            _forgotPasswordTapped = false;
          });
        },
        child: Text(
          "Forgot Password?",
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: "Roboto",
              fontSize: 16,
              decoration: _forgotPasswordTapped
                  ? TextDecoration.underline
                  : TextDecoration.none),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
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
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(getColor),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
          minimumSize: MaterialStatePropertyAll(
              Size(110 * Provider.of<Scale>(context).widthScale, 32))),
      child: Text(
        "Login",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _buildSignupText() {
    return (Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Don't have an account?",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        SizedBox(width: 5),
        InkWell(
          onTapDown: (down) {
            setState(() {
              _signUpTapped = true;
            });
          },
          onTapUp: (up) {
            setState(() {
              _signUpTapped = false;
            });
          },
          onTap: () => Navigator.of(context).pushNamed("/signup"),
          child: Text("Sign Up",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: "Roboto",
                  fontSize: 16,
                  decoration: _signUpTapped
                      ? TextDecoration.underline
                      : TextDecoration.none)),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    final widthScale = Provider.of<Scale>(context).widthScale;
    final heightScale = Provider.of<Scale>(context).heightScale;

    bool _submitted = false;
    return Scaffold(
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
                        vertical: 100.0 * heightScale),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/ostomate-logo.png",
                          scale: widthScale,
                        ),
                        SizedBox(
                          height: 9 * heightScale,
                        ),
                        Text(
                          "WELCOME TO",
                          style: TextStyle(
                              color: const Color(0xffff4647),
                              fontFamily: "Bebas Neue",
                              fontSize: 24 * widthScale),
                        ),
                        Text(
                          "OSTO-MATE",
                          style: TextStyle(
                              color: const Color(0xffff4647),
                              fontFamily: "Bebas Neue",
                              fontSize: 56 * widthScale),
                        ),
                        SizedBox(height: 20 * heightScale),
                        CustomTextFormField(
                          controller: _email,
                          hintText: "Email",
                          hintTextStyle: Theme.of(context).textTheme.bodyLarge!,
                          inputType: TextInputType.emailAddress,
                          heightScale: heightScale,
                          widthScale: widthScale,
                          validator: (email) => Validators.isValidEmail(email),
                        ),
                        //_buildPasswordTF(),
                        PasswordFormField(
                          controller: _password,
                          hintTextStyle: Theme.of(context).textTheme.bodyLarge!,
                          heightScale: heightScale,
                          widthScale: widthScale,
                          obscurePassword: _obscurePasswordInput,
                          onTap: () {
                            setState(() {
                              _obscurePasswordInput = !_obscurePasswordInput;
                            });
                          },
                          validator: (pass) => Validators.isValidPassword(pass),
                        ),
                        _buildForgotPassword(),
                        SizedBox(height: 20 * heightScale),
                        _buildLoginButton(),
                        SizedBox(height: 32 * heightScale),
                        _buildSignupText()
                      ],
                    ))),
          )
        ],
      ),
    ));
  }
}
