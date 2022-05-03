import 'package:flutter/material.dart';

class ImagePathDark implements ImagePath {
  @override
  String get splashBoozin => 'assets/images/logo_dark.png';
  @override
  String get iconFootSteps => 'assets/images/foot_dark.png';
  @override
  String get iconKcal => 'assets/images/kcal_dark.png';
}

class ImagePathLight implements ImagePath {
  @override
  String get splashBoozin => 'assets/images/logo_light.png';
  @override
  String get iconFootSteps => 'assets/images/foot_light.png';
  @override
  String get iconKcal => 'assets/images/kcal_light.png';
}

class ImagePathCommon {
  static const String splashI = 'assets/images/logo_same.png';
}

abstract class ImagePath {
  factory ImagePath(BuildContext context) => context.themeValue(
        light: ImagePathLight(),
        dark: ImagePathDark(),
      ) as ImagePath;

  String get splashBoozin;
  String get iconFootSteps;
  String get iconKcal;
}

extension ThemeValue<T> on BuildContext {
  T themeValue({required T light, T? dark}) {
    return Theme.of(this).brightness == Brightness.light
        ? light
        : dark ?? light;
  }
}
