import 'package:flutter/widgets.dart';

extension UiScaleX on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);
  double get w => screenSize.width;
  double get h => screenSize.height;

  double wp(double fraction) => w * fraction;
  double hp(double fraction) => h * fraction;

  EdgeInsets symmetric({double h = 0, double v = 0}) =>
      EdgeInsets.symmetric(horizontal: h, vertical: v);
}

