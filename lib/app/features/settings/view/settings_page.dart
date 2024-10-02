import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paperless/app/features/auth/cubit/auth_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              title: const Text('Sign Out'),
              trailing: const ShadImage.square(LucideIcons.logOut, size: 24),
              onTap: () async {
                final logout = await showShadDialog<bool>(
                  context: context,
                  variant: ShadDialogVariant.alert,
                  useRootNavigator: false,
                  builder: (context) {
                    return ShadDialog.alert(
                      title: const Text('Are you sure?'),
                      description: const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'You are about to sign out of your account.',
                        ),
                      ),
                      actions: [
                        ShadButton.outline(
                          child: const Text('Cancel'),
                          onPressed: () => context.pop(false),
                        ),
                        ShadButton(
                          child: const Text('Continue'),
                          onPressed: () => context.pop(true),
                        ),
                      ],
                    );
                  },
                );
                if ((logout ?? false) && context.mounted) {
                  await context.read<AuthCubit>().signout();
                }
              },
            ),
          ],
        ).toList(),
      ),
    );
  }
}
