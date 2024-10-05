import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paperless/exports.dart';

class DocumentPreview extends StatelessWidget with SessionManagerMixin {
  const DocumentPreview(this.document, {super.key});

  final Document document;

  String get imageUrl => activeSession.cleanServerUrl + document.thumbUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        httpHeaders: authHeaders,
      ),
    );
  }
}
