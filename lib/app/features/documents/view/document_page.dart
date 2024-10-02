import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperless/app/features/auth/cubit/auth_cubit.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          ShadButton(
            icon: const ShadImage.square(LucideIcons.logOut, size: 16),
            child: const Text('Logout'),
            onPressed: () => context.read<AuthCubit>().signout(),
          ),
        ],
      ),
    );
  }
}
