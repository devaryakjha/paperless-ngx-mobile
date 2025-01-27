import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:paperless/exports.dart'
    show AuthPage, Routes, RoutesX, SessionManager, getIt;

part 'auth_route.g.dart';

@TypedGoRoute<AuthRoute>(
  path: '/${Routes.auth}',
  name: Routes.auth,
)
final class AuthRoute extends GoRouteData {
  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final sessionManager = getIt<SessionManager>();
    if (sessionManager.activeSession != null) {
      return Routes.documents.location;
    }
    return null;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthPage();
  }
}
