import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:paperless/exports.dart' show CodegenLoader;

/// Dependency Injection
class DI extends StatelessWidget {
  const DI({
    required this.builder,
    super.key,
  });

  final WidgetBuilder builder;

  static final _supportedLocales =
      CodegenLoader.mapLocales.keys.map(Locale.new).toList();

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: _supportedLocales,
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: Builder(builder: builder),
    );
  }
}
