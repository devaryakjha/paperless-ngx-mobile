import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:paperless/core/bootstrap.config.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> bootstrap(
  Widget Function(WidgetsBinding widgetsBinding) builder,
) async {
  await runZonedGuarded(
    () async {
      getIt.init();
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

  await EasyLocalization.ensureInitialized();

  await Hive.initFlutter();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
}
