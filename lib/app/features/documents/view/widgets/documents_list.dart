import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:paperless/app/features/documents/view/widgets/document_preview.dart';
import 'package:paperless/exports.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

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
