import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paperless/exports.dart';

part 'logged_in_route.g.dart';

@TypedStatefulShellRoute<LoggedInRoute>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<HomePageData>(
          path: '/${Routes.home}',
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<DocumentsPageData>(
          path: '/${Routes.documents}',
        ),
        TypedGoRoute<DocumentPreviewPageData>(
          path: '/${Routes.documents}/:docId',
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<ScannerPageData>(
          path: '/${Routes.scanner}',
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<LabelsPageData>(
          path: '/${Routes.labels}',
        ),
      ],
    ),
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<SettingsPageData>(
          path: '/${Routes.settings}',
        ),
      ],
    ),
  ],
)
final class LoggedInRoute extends StatefulShellRouteData {
  const LoggedInRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return BlocProvider(
      lazy: false,
      create: (context) => DocumentsCubit()..getAll(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomNavBar(
              currentIndex: navigationShell.currentIndex,
              onDestinationSelected: (idx) => navigationShell.goBranch(
                idx,
                initialLocation: navigationShell.currentIndex == idx,
              ),
            ),
          );
        },
      ),
    );
  }
}

final class HomePageData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    // return HomePage(key: state.pageKey);
    return const Placeholder();
  }
}

final class ScannerPageData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    // return ScannerPage(key: state.pageKey);
    return const Placeholder();
  }
}

final class LabelsPageData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    // return LabelsPage(key: state.pageKey);
    return const Placeholder();
  }
}

final class SettingsPageData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SettingsPage(key: state.pageKey);
  }
}
