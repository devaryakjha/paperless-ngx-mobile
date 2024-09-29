import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:paperless/exports.dart'
    show $authRoute, Routes, RoutesX, rootNavigationKey;

final router = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: Routes.auth.location,
  debugLogDiagnostics: kDebugMode,
  routes: [
    $authRoute,
  ],
);
