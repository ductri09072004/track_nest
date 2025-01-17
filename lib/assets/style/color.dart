import 'package:flutter/material.dart';

class AppColors {
  // Purple - Màu chủ đạo
  static const MaterialColor purple = MaterialColor(
    _purplePrimaryValue,
    <int, Color>{
      100: Color(0xFFA561CA),
      200: Color(0xFF8B3BB7),
      300: Color(0xFF791CAC),
      400: Color(0xFF600891),
      500: Color(0xFF4B0572),
    },
  );
  static const int _purplePrimaryValue = 0xFF791CAC;

  // Pink - Màu nhấn
  static const MaterialColor pink = MaterialColor(
    _pinkPrimaryValue,
    <int, Color>{
      100: Color(0xFFE064AA),
      200: Color(0xFFD43D92),
      300: Color(0xFFCE187F),
      400: Color(0xFFAE0062),
      500: Color(0xFF88004D),
    },
  );
  static const int _pinkPrimaryValue = 0xFFCE187F;

  // Blue - Màu nhấn
  static const MaterialColor white = MaterialColor(
    _whitePrimaryValue,
    <int, Color>{
      100: Color(0xFFFDFDFD),
      200: Color(0xFFCFCFCF),
      300: Color(0xFFA7A7A7),
      400: Color(0xFF828282),
      500: Color(0xFF5E5E5E),
    },
  );
  static const int _whitePrimaryValue = 0xFFFDFDFD;

  static const MaterialColor black = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{
      100: Color(0xFF808080),
      200: Color(0xFF656464),
      300: Color(0xFF4B4A49),
      400: Color(0xFF32312F),
      500: Color(0xFF1B1A18),
    },
  );
  static const int _blackPrimaryValue = 0xFF1B1A18;

  static const Color orange = Color(0xFFEA580C);
  static const Color red = Color(0xFFDC2626);
  static const Color green = Color(0xFF5CB338);
}
