import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

extension ThemeExtension on BuildContext {
  ShadThemeData get shadTheme => ShadTheme.of(this);

  ShadColorScheme get colorScheme => shadTheme.colorScheme;

  Color get fgColor => colorScheme.foreground;

  Color get bgColor => colorScheme.background;

  ShadTextTheme get textTheme => shadTheme.textTheme;

  ShadButtonTheme get primaryButtonTheme => shadTheme.primaryButtonTheme;
}
