import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paperless/exports.dart' show DI, router;

class Paperless extends StatefulWidget {
  const Paperless(
    this.binding, {
    super.key,
  });

  final WidgetsBinding binding;

  @override
  State<Paperless> createState() => _PaperlessState();
}

class _PaperlessState extends State<Paperless> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.binding.allowFirstFrame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DI(
      builder: (context) {
        return MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateTitle: (context) => context.tr('app_title'),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
        );
      },
    );
  }
}
