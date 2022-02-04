import 'package:e_commerce_app_flutter/components/async_progress_dialog.dart';
import 'package:e_commerce_app_flutter/exceptions/firebaseauth/messeged_firebaseauth_exception.dart';
import 'package:e_commerce_app_flutter/exceptions/firebaseauth/signin_exceptions.dart';
import 'package:e_commerce_app_flutter/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_commerce_app_flutter/services/authentification/authentification_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import '../../../components/default_button.dart';
import 'package:flutter/material.dart';
import 'social_icon.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'or_divider.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  void dispose() {
    emailFieldController.dispose();
    passwordFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(10)),
          _buildPasswordField(passwordFieldController: passwordFieldController),
          SizedBox(height: getProportionateScreenHeight(10)),
          buildForgotPasswordWidget(context),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Entrar",
            press: signInButtonCallback,
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          OrDivider(),
          Text(
            "Ingresa con:",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SocalIcon(
                iconSrc: "assets/icons/facebook.svg",
                press: () {},
              ),
              SocalIcon(
                iconSrc: "assets/icons/google-plus.svg",
                press: () {
                  // Provider.of<LoginController>(context, listen: false)
                  //     .googleLogin();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildForgotPasswordWidget(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ForgotPasswordScreen(),
                ));
          },
          child: Text(
            "¿Olvidaste tu contraseña?",
            style: TextStyle(
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }

  // Widget buildPasswordFormField(bool _passwordVisible) {
  //   return TextFormField(
  //     controller: passwordFieldController,
  //     cursorColor: Colors.deepOrange,
  //     obscureText: !_passwordVisible,
  //     decoration: InputDecoration(
  //         fillColor: Colors.grey[150],
  //         filled: true,
  //         focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(30),
  //             borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
  //         enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(30),
  //             borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
  //         hintText: "Ingresa tu contraseña",
  //         prefixIcon: Padding(
  //           padding: const EdgeInsets.all(15.0),
  //           child: Icon(
  //             Icons.lock,
  //             color: Colors.deepOrange,
  //             size: 28,
  //           ),
  //         ),
  //       suffixIcon: IconButton(
  //         icon: Icon(
  //           // Based on passwordVisible state choose the icon
  //           _passwordVisible
  //               ? Icons.visibility
  //               : Icons.visibility_off,
  //           color: kPrimaryColor,
  //         ),
  //         onPressed: () {
  //           // Update the state i.e. toogle the state of passwordVisible variable
  //           print("touched");
  //           print('En el metodo $_passwordVisible');
  //           setState(() {
  //             _passwordVisible = true;
  //           }
  //           );
  //           print('En el metodo 2 $_passwordVisible');
  //         },
  //       ),),
  //     validator: (value) {
  //       if (passwordFieldController.text.isEmpty) {
  //         return kPassNullError;
  //       } else if (passwordFieldController.text.length < 8) {
  //         return kShortPassError;
  //       }
  //       return null;
  //     },
  //     autovalidateMode: AutovalidateMode.onUserInteraction,
  //   );
  // }

  Widget buildEmailFormField() {
    return TextFormField(
      controller: emailFieldController,
      cursorColor: Colors.deepOrange,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintText: "Ingresa tu correo",
          fillColor: Colors.grey[150],
          filled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
          //border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 15, 15, 15),
            child: Icon(
              Icons.email,
              color: Colors.deepOrange,
              size: 28,
            ),
          )),
      validator: (value) {
        if (emailFieldController.text.isEmpty) {
          return kEmailNullError;
        } else if (!emailValidatorRegExp.hasMatch(emailFieldController.text)) {
          return kInvalidEmailError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }

  Future<void> signInButtonCallback() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final AuthentificationService authService = AuthentificationService();
      bool signInStatus = false;
      String? snackbarMessage;
      try {
        final signInFuture = authService.signIn(
          email: emailFieldController.text.trim(),
          password: passwordFieldController.text.trim(),
        );
        //signInFuture.then((value) => signInStatus = value);
        signInStatus = await showDialog(
          context: context,
          builder: (context) {
            return AsyncProgressDialog(
              signInFuture,
              message: Text("Signing in to account"),
              onError: (e) {
                snackbarMessage = e.toString();
              },
            );
          },
        );
        if (signInStatus == true) {
          snackbarMessage = "Signed In Successfully";
        } else {
          if (snackbarMessage == null) {
            throw FirebaseSignInAuthUnknownReasonFailure();
          } else {
            throw FirebaseSignInAuthUnknownReasonFailure(
                message: snackbarMessage!);
          }
        }
      } on MessagedFirebaseAuthException catch (e) {
        snackbarMessage = e.message;
      } catch (e) {
        snackbarMessage = e.toString();
      } finally {
        Logger().i(snackbarMessage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage!),
          ),
        );
      }
    }
  }
}

class _buildPasswordField extends StatefulWidget {
  final TextEditingController passwordFieldController;
  bool _passwordVisible = false;

  _buildPasswordField({
    Key? key,
    required this.passwordFieldController,
  }) : super(key: key);

  @override
  _buildPasswordFieldState createState() => _buildPasswordFieldState();
}

class _buildPasswordFieldState extends State<_buildPasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordFieldController,
      cursorColor: Colors.deepOrange,
      obscureText: !widget._passwordVisible,
      decoration: InputDecoration(
        fillColor: Colors.grey[150],
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.deepOrange, width: 2)),
        hintText: "Ingresa tu contraseña",
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 15, 15, 15),
          child: Icon(
            Icons.lock,
            color: Colors.deepOrange,
            size: 28,
          ),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 20, 5),
          child: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              widget._passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
              size: 28,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              print("touched");
              print('En el metodo $widget._passwordVisible');
              setState(() {
                widget._passwordVisible = !widget._passwordVisible;
              });
              print('En el metodo 2 $widget._passwordVisible');
            },
          ),
        ),
      ),
      validator: (value) {
        if (widget.passwordFieldController.text.isEmpty) {
          return kPassNullError;
        } else if (widget.passwordFieldController.text.length < 8) {
          return kShortPassError;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
