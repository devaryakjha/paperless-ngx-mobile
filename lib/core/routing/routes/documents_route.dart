import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paperless/app/features/exports.dart';

final class DocumentsPageData extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DocumentsPage(key: state.pageKey);
  }
}

final class DocumentPreviewPageData extends GoRouteData {
  const DocumentPreviewPageData(this.docId);

  final int docId;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocSelector<DocumentsCubit, DocumentsState, Document?>(
      selector: (state) => state.findById(docId),
      builder: (context, document) {
        if (document == null) {
          return const SizedBox.shrink();
        }
        return DocumentPreviewPage(document, key: state.pageKey);
      },
    );
  }
}
