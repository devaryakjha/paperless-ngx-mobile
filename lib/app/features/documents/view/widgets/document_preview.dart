import 'package:flutter/material.dart';
import 'package:paperless/exports.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DocumentPreview extends StatelessWidget with SessionManagerMixin {
  const DocumentPreview(this.document, {super.key});

  final Document document;

  String get imageUrl => activeSession.cleanServerUrl + document.thumbUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ShadImage.square(
        imageUrl,
        size: 48,
        headers: authHeaders,
        fit: BoxFit.cover,
      ),
    );
  }
}
