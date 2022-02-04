import 'package:flutter/material.dart';
import 'package:e_commerce_app_flutter/size_config.dart';

const String appName = "E-Shopee";

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

const double screenPadding = 10;

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Por favor, introduce tu correo";
const String kInvalidEmailError = "Por favor, introduce un correo válido";
const String kPassNullError = "Por favor, introduce tu contraseña";
const String kShortPassError = "La contraseña es muy corta";
const String kMatchPassError = "La contraseña no coincide";
const String kNamelNullError = "Por favor, introduce tu nombre";
const String kPhoneNumberNullError = "Por favor, introduce no número de teléfono";
const String kAddressNullError = "Por favor, introduce tu dirección";
const String FIELD_REQUIRED_MSG = "Este campo es obligatorio";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
