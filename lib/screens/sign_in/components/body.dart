import 'package:e_commerce_app_flutter/constants.dart';

import 'sign_in_form.dart';

import '../../../size_config.dart';
import 'package:flutter/material.dart';
import '../../../components/no_account_text.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(screenPadding)),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                Text(
                  "Hola de nuevo\n¡Kaserit@!",
                  style: headingStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Entra con tu correo y contraseña",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                SignInForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                NoAccountText(),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
