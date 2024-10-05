import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:paperless/exports.dart';

class DocumentPreview extends StatelessWidget with SessionManagerMixin {
  const DocumentPreview(
    this.document, {
    super.key,
    this.size = const Size.square(48),
  });

  final Document document;
  final Size size;

  String get imageUrl => activeSession.cleanServerUrl + document.thumbUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        width: size.width,
        height: size.height,
        fit: BoxFit.cover,
        imageUrl: imageUrl,
        httpHeaders: authHeaders,
      ),
    );
  }
}
