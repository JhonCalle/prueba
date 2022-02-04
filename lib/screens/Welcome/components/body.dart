import 'package:e_commerce_app_flutter/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import 'background.dart';
import 'package:e_commerce_app_flutter/components/default_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This size provide us total height and width of our screen
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: <Widget>[
            const Text(
              "BIENVENIDO A\n¡TIENDAS YA!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: kPrimaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            SizedBox(height: 60),
            DefaultButton(
              text: "ENTRAR",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));

              },
            ),
            DefaultButton(
              text: "REGISTRARME",
              color: kPrimaryLightColor,
              press: () {
                //Navigator.pushNamed(context, '/signup_buyer');
              },
              textColor: Colors.black,
            ),
            DefaultButton(
              text: "Cart",
              color: kPrimaryLightColor,
              press: () {
                //Navigator.pushNamed(context, '/cart');
              },
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
