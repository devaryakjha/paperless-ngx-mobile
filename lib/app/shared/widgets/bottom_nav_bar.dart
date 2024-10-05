import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:paperless/exports.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  static final _navItems = [
    NavItem(icon: LucideIcons.house, label: 'Home'.tr()),
    NavItem(icon: LucideIcons.fileText, label: 'Documents'.tr()),
    NavItem(icon: LucideIcons.scan, label: 'Scanner'.tr()),
    NavItem(icon: LucideIcons.tag, label: 'Labels'.tr()),
    NavItem(icon: LucideIcons.settings, label: 'Settings'.tr()),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.only(top: 16),
      elevation: 10,
      height: 56,
      color: context.colorScheme.secondary,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _navItems.length,
        itemBuilder: (context, index) =>
            _buildNavItem(context, _navItems[index], index),
        separatorBuilder: (context, index) => const Gap(8),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, NavItem item, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected
        ? context.colorScheme.primary
        : context.colorScheme.secondaryForeground.withOpacity(0.5);

    return AnimatedSize(
      alignment: Alignment.centerLeft,
      duration: const Duration(milliseconds: 200),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: _getPadding(index),
        decoration: BoxDecoration(
          color: isSelected ? context.bgColor : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Builder(
          builder: (context) {
            return ShadButton(
              size: ShadButtonSize.sm,
              backgroundColor: Colors.transparent,
              onPressed: () {
                onDestinationSelected(index);
                Scrollable.ensureVisible(
                  context,
                  alignmentPolicy:
                      ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
                );
              },
              icon: ShadImage.square(item.icon, size: 24),
              foregroundColor: color,
              pressedBackgroundColor: context.bgColor,
              pressedForegroundColor: context.fgColor,
              gap: isSelected ? 12 : 0,
              child: SizedBox(
                width: isSelected ? null : 0,
                child: Text(
                  item.label,
                  style: context.textTheme.small,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  EdgeInsets _getPadding(int index) {
    return index == _navItems.length - 1
        ? const EdgeInsets.only(right: 16)
        : index == 0
            ? const EdgeInsets.only(left: 16)
            : EdgeInsets.zero;
  }
}

final class NavItem extends Equatable {
  const NavItem({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  List<Object> get props => [icon, label];
}
