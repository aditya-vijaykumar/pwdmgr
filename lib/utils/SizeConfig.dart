import 'package:flutter/cupertino.dart';

class SZ {
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;

  static double _safeAreaHorizontal = 0.0;
  static double _safeAreaVertical = 0.0;
  static double H = 0.0;
  static double V = 0.0;

  static void init(BuildContext context) {
    MediaQueryData _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    H = (screenWidth - _safeAreaHorizontal) / 100;
    V = (screenHeight - _safeAreaVertical) / 100;
  }
}
