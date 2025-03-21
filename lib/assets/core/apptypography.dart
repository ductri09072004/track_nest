import 'package:flutter/material.dart';

class AppTypo {
  // Font Family
  static const String fontFamily = 'Lato';

  // Font Weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Font Sizes
  static const double heading1 = 36;
  static const double heading2 = 30;
  static const double heading3 = 24;
  static const double heading4 = 20;
  static const double heading5 = 18;
  static const double heading6 = 16;

  static const double stLg = 18;
  static const double st = 16;

  static const double ctLg = 18;
  static const double ct = 16;
  static const double ctSm = 14;

  static const double lb1 = 14;
  static const double lb2 = 12;

  // Text Styles
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: heading1,
    fontWeight: bold,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: heading2,
    fontWeight: bold,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: heading3,
    fontWeight: bold,
  );

  static const TextStyle h4 = TextStyle(
    fontFamily: fontFamily,
    fontSize: heading4,
    fontWeight: bold,
  );

  static const TextStyle h5 = TextStyle(
    fontFamily: fontFamily,
    fontSize: heading5,
    fontWeight: bold,
  );

  static const TextStyle h6 = TextStyle(
    fontFamily: fontFamily,
    fontSize: heading6,
    fontWeight: bold,
  );

  static const TextStyle subtitleLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: stLg,
    fontWeight: semibold,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontFamily,
    fontSize: st,
    fontWeight: semibold,
  );

  static const TextStyle contentLg = TextStyle(
    fontFamily: fontFamily,
    fontSize: ctLg,
    fontWeight: regular,
  );

  static const TextStyle content = TextStyle(
    fontFamily: fontFamily,
    fontSize: ct,
    fontWeight: regular,
  );

  static const TextStyle contentSm = TextStyle(
    fontFamily: fontFamily,
    fontSize: ctSm,
    fontWeight: regular,
  );

  static const TextStyle label1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: lb1,
    fontWeight: light,
  );

  static const TextStyle label2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: lb2,
    fontWeight: light,
  );
}
