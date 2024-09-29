import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paperless/exports.dart' show Assets, ThemeExtension;

class PaperlessLogo extends StatelessWidget {
  const PaperlessLogo({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Assets.logos.adaptiveLogo.svg(
      width: 40,
      height: 40,
      theme: SvgTheme(
        currentColor: color ?? context.fgColor,
      ),
    );
  }
}
