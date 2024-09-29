import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paperless/exports.dart' show DI, router;
import 'package:shadcn_ui/shadcn_ui.dart';

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
        return ShadApp.router(
          darkTheme: ShadThemeData(
            colorScheme: const ShadZincColorScheme.dark(),
            brightness: Brightness.dark,
            textTheme: ShadTextTheme.fromGoogleFont(GoogleFonts.dmSans),
          ),
          themeMode: ThemeMode.dark,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateTitle: (context) => context.tr('app_title'),
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          materialThemeBuilder: (context, theme) {
            return theme.copyWith(
              appBarTheme: theme.appBarTheme.copyWith(
                centerTitle: false,
              ),
            );
          },
        );
      },
    );
  }
}
