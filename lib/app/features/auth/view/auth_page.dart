import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:paperless/exports.dart' show PaperlessLogo;

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('app_title').tr(),
        actions: const [
          PaperlessLogo(),
          Gap(16),
        ],
      ),
    );
  }
}
