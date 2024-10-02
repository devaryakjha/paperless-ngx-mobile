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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: docs.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final doc = docs[index];
          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? 24 : 0),
            child: ShadCard(
              padding: const EdgeInsets.all(16),
              leading: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: DocumentPreview(doc),
              ),
              rowMainAxisSize: MainAxisSize.min,
              rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
              rowCrossAxisAlignment: CrossAxisAlignment.center,
              columnCrossAxisAlignment: CrossAxisAlignment.stretch,
              title: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 4),
                child: Text(
                  doc.title,
                  style: context.textTheme.list,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              description: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(
                  doc.created.formatted,
                  style: context.textTheme.small.copyWith(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShadButton.ghost(
                    height: 32,
                    width: 32,
                    icon: const ShadImage.square(
                      LucideIcons.externalLink,
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                  ShadButton.ghost(
                    height: 32,
                    width: 32,
                    icon:
                        const ShadImage.square(LucideIcons.download, size: 24),
                    onPressed: () {},
                  ),
                  ShadButton.ghost(
                    height: 32,
                    width: 32,
                    icon: const ShadImage.square(LucideIcons.trash, size: 24),
                    onPressed: () {},
                  ),
                ],
              ),
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
