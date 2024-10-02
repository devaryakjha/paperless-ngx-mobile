import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paperless/exports.dart'
    show
        $authRoute,
        $loggedInRoute,
        AuthCubit,
        AuthState,
        Routes,
        RoutesX,
        rootNavigationKey;

final router = GoRouter(
  navigatorKey: rootNavigationKey,
  initialLocation: Routes.auth.location,
  debugLogDiagnostics: kDebugMode,
  routes: [
    ShellRoute(
      parentNavigatorKey: rootNavigationKey,
      builder: (context, state, child) {
        return BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              previous.activeSession != current.activeSession,
          listener: (context, state) {
            if (state.activeSession == null) {
              context.go(Routes.auth.location);
              return;
            }
            if (state.activeSession != null) {
              context.go(Routes.documents.location);
              return;
            }
          },
          child: child,
        );
      },
      routes: [
        $authRoute,
        $loggedInRoute,
      ],
    ),
  ],
);
