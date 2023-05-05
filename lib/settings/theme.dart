import 'package:flutter/material.dart';

class ColorPalette {
  static const primary = Color(0xFF5099f8);
  static const secondary = Color(0xFF4649a8);
  static const tertiary = Color(0xFFffa532);
  static const alternate = Color(0xFFed7098);
  static const Color primaryBackground = Color(0xFF2c385e);
  static const secondaryBackground = Color(0xFFfefefe);
  static const primaryText = Color(0xFFf7fefe);
  static const secondaryText = Color(0xFF282828);
  static final secondaryText2 = Color(0xFF282828).withOpacity(0.5);
}

class Typo {
  static const title1 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: ColorPalette.primaryText);
  static const textButton = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: ColorPalette.primaryText);
  static const textField1 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: ColorPalette.secondaryText);
  static final hintText = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: ColorPalette.secondaryText2);
  static const labelText1 = TextStyle(
      fontFamily: 'Source Sans Pro',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorPalette.primaryText);
  static const labelText2 = TextStyle(
      fontFamily: 'Source Sans Pro',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorPalette.secondaryText);
  static const bodyText1 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: ColorPalette.secondaryText);
  static const bodyText2 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorPalette.secondaryText);
  static const bodyText3 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: ColorPalette.secondaryText);
  static const bodyText4 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 22,
      color: ColorPalette.primaryText);
  static const bodyText5 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: ColorPalette.primaryText);
  static const bodyText6 = TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: ColorPalette.secondaryText);
}
