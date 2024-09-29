import 'package:flutter/material.dart';
import 'package:paperless/exports.dart' show DI, router;

class Paperless extends StatelessWidget {
  const Paperless(
    this.binding, {
    super.key,
  });

  final WidgetsBinding binding;

  @override
  Widget build(BuildContext context) {
    return DI(
      builder: (context) {
        return MaterialApp.router(
          routerConfig: router,
        );
      },
    );
  }
}
