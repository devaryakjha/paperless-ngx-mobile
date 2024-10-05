import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paperless/app/features/documents/view/widgets/document_preview.dart';
import 'package:paperless/exports.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DocumentCard extends StatefulWidget {
  const DocumentCard(this.document, {super.key});

  final Document document;

  @override
  State<DocumentCard> createState() => _DocumentCardState();
}

class _DocumentCardState extends State<DocumentCard> {
  late final popoverController = ShadPopoverController();

  @override
  void dispose() {
    popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShadCard(
      padding: const EdgeInsets.all(16),
      leading: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: DocumentPreview(widget.document),
      ),
      rowMainAxisSize: MainAxisSize.min,
      rowMainAxisAlignment: MainAxisAlignment.spaceBetween,
      rowCrossAxisAlignment: CrossAxisAlignment.center,
      columnCrossAxisAlignment: CrossAxisAlignment.stretch,
      title: Padding(
        padding: const EdgeInsets.only(right: 8, bottom: 4),
        child: Text(
          widget.document.title,
          style: context.textTheme.list,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      description: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Text(
          widget.document.created.formatted,
          style: context.textTheme.small.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      trailing: ShadPopover(
        controller: popoverController,
        popover: (BuildContext context) {
          return SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ActionButton(
                  icon: LucideIcons.externalLink,
                  label: 'Open in browser',
                  onPressed: () {
                    // TODO: Open in browser
                  },
                ),
                ActionButton(
                  icon: LucideIcons.download,
                  label: 'Download',
                  onPressed: () {
                    // TODO: Download
                  },
                ),
                ActionButton(
                  icon: LucideIcons.trash,
                  label: 'Delete',
                  onPressed: () {
                    // TODO: Delete
                  },
                ),
              ],
            ),
          );
        },
        child: ShadButton.ghost(
          size: ShadButtonSize.sm,
          icon: const ShadImage.square(LucideIcons.ellipsis, size: 16),
          onPressed: popoverController.toggle,
        ),
      ),
    );
  }
}

extension on DateTime {
  String get formatted => DateFormat.yMMMEd().format(this);
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.icon,
    required this.onPressed,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ShadButton.ghost(
      size: ShadButtonSize.sm,
      icon: ShadImage.square(icon, size: 16),
      onPressed: onPressed,
      mainAxisAlignment: MainAxisAlignment.start,
      child: Text(
        label,
        textAlign: TextAlign.left,
        style: context.textTheme.small,
      ),
    );
  }
}
