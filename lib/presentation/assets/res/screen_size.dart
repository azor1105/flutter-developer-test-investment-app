import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@immutable
class ScreenSize {
  const ScreenSize._();

  static late double w2;
  static late double w4;
  static late double w6;
  static late double w8;
  static late double w10;
  static late double w12;
  static late double w14;
  static late double w16;
  static late double w18;
  static late double w20;
  static late double w22;
  static late double w24;
  static late double w26;
  static late double w28;
  static late double w30;
  static late double w32;
  static late double w34;
  static late double w36;
  static late double w38;
  static late double w40;

  static late double h2;
  static late double h4;
  static late double h6;
  static late double h8;
  static late double h10;
  static late double h12;
  static late double h14;
  static late double h16;
  static late double h18;
  static late double h20;
  static late double h22;
  static late double h24;
  static late double h26;
  static late double h28;
  static late double h30;
  static late double h32;
  static late double h34;
  static late double h36;
  static late double h38;
  static late double h40;
  static late double h42;
  static late double h44;
  static late double h46;
  static late double h48;

  static void setSizes() {
    w2 = 2.w;
    w4 = 4.w;
    w6 = 6.w;
    w8 = 8.w;
    w10 = 10.w;
    w12 = 12.w;
    w14 = 14.w;
    w16 = 16.w;
    w18 = 18.w;
    w20 = 20.w;
    w22 = 22.w;
    w24 = 24.w;
    w26 = 26.w;
    w28 = 28.w;
    w30 = 30.w;
    w32 = 32.w;
    w34 = 34.w;
    w36 = 36.w;
    w38 = 38.w;
    w40 = 40.w;

    h2 = 2.h;
    h4 = 4.h;
    h6 = 6.h;
    h8 = 8.h;
    h10 = 10.h;
    h12 = 12.h;
    h14 = 14.h;
    h16 = 16.h;
    h18 = 18.h;
    h20 = 20.h;
    h22 = 22.h;
    h24 = 24.h;
    h26 = 26.h;
    h28 = 28.h;
    h30 = 30.h;
    h32 = 32.h;
    h34 = 34.h;
    h36 = 36.h;
    h38 = 38.h;
    h40 = 40.h;
    h42 = 42.h;
    h44 = 44.h;
    h46 = 46.h;
    h48 = 48.h;
  }

  static double getViewInsets(BuildContext context) {
    return MediaQuery.viewInsetsOf(context).bottom;
  }

  static double getViewPadding(BuildContext context) {
    if (MediaQuery.viewPaddingOf(context).bottom == 0) {
      return 16.h;
    }
    return MediaQuery.viewPaddingOf(context).bottom;
  }
}


extension DeviceTypeExtension on DeviceType {
  bool get isMobile => this == DeviceType.mobile;
  bool get isTablet => this == DeviceType.tablet;
}

extension OrientationExtension on Orientation {
  bool get isPortrait => this == Orientation.portrait;
  bool get isLandscape => this == Orientation.landscape;
}