import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
        title: Text(tr('Documents')),
        actions: const [
          ShadButton(
            height: 24,
            width: 24,
            icon: ShadImage.square(LucideIcons.search, size: 16),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : const DocumentsList(),
    );
  }
}

class DocumentsList extends StatelessWidget {
  const DocumentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final docs = context.select(
      (DocumentsCubit state) => state.state.document,
    );
    return RefreshIndicator(
      onRefresh: context.read<DocumentsCubit>().getAll,
      child: ListView.separated(
        itemCount: docs.length,
        separatorBuilder: (context, index) => const Gap(24),
        itemBuilder: (context, index) {
          final doc = docs[index];
          return ShadCard(
            padding: const EdgeInsets.all(16),
            leading: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: DocumentPreview(doc),
            ),
            rowMainAxisSize: MainAxisSize.min,
            rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
            rowCrossAxisAlignment: CrossAxisAlignment.center,
            columnCrossAxisAlignment: CrossAxisAlignment.stretch,
            title: Text(
              doc.title,
              style: context.textTheme.list,
            ),
            description: Text(
              doc.created.formatted,
              style: context.textTheme.small,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShadButton.ghost(
                  height: 24,
                  width: 24,
                  icon: const ShadImage.square(
                    LucideIcons.externalLink,
                    size: 16,
                  ),
                  onPressed: () {},
                ),
                const Gap(4),
                ShadButton.ghost(
                  height: 24,
                  width: 24,
                  icon: const ShadImage.square(LucideIcons.download, size: 16),
                  onPressed: () {},
                ),
                const Gap(4),
                ShadButton.ghost(
                  height: 24,
                  width: 24,
                  icon: const ShadImage.square(LucideIcons.trash, size: 16),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension on DateTime {
  String get formatted => DateFormat.yMMMEd().format(this);
}

class DocumentPreview extends StatelessWidget {
  const DocumentPreview(this.document, {super.key});

  final Document document;

  String get imageUrl =>
      cleanupServerUrl(getIt<SessionManager>().activeSession!.serverUri)
          .toString() +
      document.thumUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        httpHeaders: {
          'Authorization':
              'Token ${getIt<SessionManager>().activeSession!.token}',
        },
      ),
    );
  }
}
