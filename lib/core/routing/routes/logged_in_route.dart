import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:paperless/app/features/documents/view/document_page.dart';
import 'package:paperless/exports.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

part 'logged_in_route.g.dart';

@TypedStatefulShellRoute<LoggedInRoute>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<DocumentsPageData>(
          path: '/${Routes.documents}',
        ),
      ],
    ),
  ],
)
final class LoggedInRoute extends StatefulShellRouteData {
  const LoggedInRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final sessionManager = getIt<SessionManager>();
    if (sessionManager.activeSession == null) {
      return Routes.auth.location;
    }
    return null;
  }

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
        destinations: const [
          NavigationDestination(
            icon: ShadImage.square(LucideIcons.fileText, size: 24),
            label: 'Documents',
          ),
          NavigationDestination(
            icon: ShadImage.square(LucideIcons.settings, size: 24),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

final class DocumentsPageData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DocumentsPage(key: state.pageKey);
  }
}
