import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paperless/app/features/documents/view/widgets/documents_list.dart';
import 'package:paperless/exports.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final loading = context.select(
      (DocumentsCubit state) => state.state.fetchState.isLoading,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 4,
        title: ShadInputFormField(
          prefix: const ShadImage.square(LucideIcons.menu, size: 24),
          placeholder: Text(tr('Search Documents')),
          suffix: const ShadImage.square(LucideIcons.search, size: 24),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : const DocumentsList(),
    );
  }
}
