// ignore_for_file: unused_field

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:paperless/exports.dart'
    show
        CodegenLoader,
        ConnectivityChecker,
        ConnectivityCheckerImpl,
        DismissFocusOverlay;

/// Dependency Injection
class DI extends StatefulWidget {
  const DI({
    required this.builder,
    super.key,
  });

  final WidgetBuilder builder;

  static final _supportedLocales = [const Locale('en')];

  @override
  State<DI> createState() => _DIState();
}

class _DIState extends State<DI> {
  late final ConnectivityChecker _connectivityChecker;

  @override
  void initState() {
    super.initState();
    _connectivityChecker = ConnectivityCheckerImpl(Connectivity());
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: DI._supportedLocales,
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: Builder(
        builder: (context) {
          final app = widget.builder(context);
          return DismissFocusOverlay(
            // child: BlocProvider.value(
            //   value: _authCubit,
            //   child: app,
            // ),
            child: app,
          );
        },
      ),
    );
  }
}
