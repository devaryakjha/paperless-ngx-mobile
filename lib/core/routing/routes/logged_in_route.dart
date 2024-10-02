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
      bottomNavigationBar: BottomNavBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: navigationShell.goBranch,
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

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;
    return Container(
      height: 56 + bottomPadding,
      color: context.colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavDest(
              label: 'Home',
              icon: LucideIcons.house,
              onPressed: () => onDestinationSelected(0),
              selected: currentIndex == 0,
            ),
            BottomNavDest(
              label: 'Documents',
              icon: LucideIcons.fileText,
              onPressed: () => onDestinationSelected(1),
              selected: currentIndex == 1,
            ),
            BottomNavDest(
              label: 'Scanner',
              icon: LucideIcons.scan,
              onPressed: () => onDestinationSelected(2),
              selected: currentIndex == 2,
            ),
            BottomNavDest(
              label: 'Labels',
              icon: LucideIcons.tag,
              onPressed: () => onDestinationSelected(3),
              selected: currentIndex == 3,
            ),
            BottomNavDest(
              label: 'Settings',
              icon: LucideIcons.settings,
              onPressed: () => onDestinationSelected(4),
              selected: currentIndex == 4,
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavDest extends StatefulWidget {
  const BottomNavDest({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
    this.selected = false,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  @override
  State<BottomNavDest> createState() => _BottomNavDestState();
}

class _BottomNavDestState extends State<BottomNavDest> {
  late bool hidden;

  @override
  void initState() {
    super.initState();
    hidden = !widget.selected;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.centerLeft,
      onEnd: () {
        hidden = !widget.selected;
        setState(() {});
      },
      child: ShadTooltip(
        builder: (context) {
          return Text(widget.label);
        },
        child: ShadButton.raw(
          variant:
              !hidden ? ShadButtonVariant.primary : ShadButtonVariant.secondary,
          backgroundColor:
              context.colorScheme.background.withAlpha(!hidden ? 120 : 0),
          foregroundColor:
              context.colorScheme.foreground.withAlpha(!hidden ? 255 : 200),
          icon: ShadImage.square(widget.icon, size: 16),
          onPressed: widget.onPressed,
          child: widget.selected ? Text(widget.label) : null,
        ),
      ),
    );
  }
}
