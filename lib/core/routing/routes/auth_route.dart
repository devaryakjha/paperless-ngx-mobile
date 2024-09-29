import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:paperless/exports.dart' show AuthPage, Routes;

part 'auth_route.g.dart';

@TypedGoRoute<AuthRoute>(
  path: '/${Routes.auth}',
  name: Routes.auth,
)
final class AuthRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthPage();
  }
}
