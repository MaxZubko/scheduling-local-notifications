import 'package:flutter/material.dart';
import 'colors.dart' as colors;

mixin Styles {
  static const TextStyle robotoWhiteS16W700 = TextStyle(
    color: colors.Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle robotoGreyS32W700 = TextStyle(
    color: colors.Colors.grey,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle robotoGreyDarkS16W400 = TextStyle(
    color: colors.Colors.greyDark,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle robotoDarkS16W400 = TextStyle(
    color: colors.Colors.mainDark,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle robotoDarkS24W700 = TextStyle(
    color: colors.Colors.mainDark,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle robotoDarkS32W700 = TextStyle(
    color: colors.Colors.mainDark,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );

  // auth error
  static const TextStyle robotoRedS14W500 = TextStyle(
    color: colors.Colors.red,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
}
