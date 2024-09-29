import 'dart:async';

import 'package:flutter/widgets.dart';

Future<void> bootstrap(
  Widget Function(WidgetsBinding widgetsBinding) builder,
) async {
  await runZonedGuarded(
    () async {
      // Initialize the Flutter binding.
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized()
        ..deferFirstFrame();

      // Initialize the services.
      await initServices();

      // Run the app.
      runApp(builder(widgetsBinding));
    },
    (_, __) {
      // Handle errors.
    },
  );
}

Future<void> initServices() async {
  // Initialize the services. like Firebase, api,
}
