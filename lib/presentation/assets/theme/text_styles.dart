import 'package:flutter/material.dart';
import 'package:stock_investment_app/presentation/assets/asset_index.dart';

class AppTextStyles {
  static const String _fontFamily = 'SFProText';

  static const TextStyle headline1 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 32,
    letterSpacing: -1.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: -0.5,
  );

  static TextStyle subtitle1 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    letterSpacing: 0.1,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.normal,
    fontSize: 14,
    letterSpacing: 0.25,
  );

  static TextStyle caption = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    color: BaseColors.textSecondary,
    fontSize: 14.sp,
  );

  static const TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    letterSpacing: 1.25,
  );
}
