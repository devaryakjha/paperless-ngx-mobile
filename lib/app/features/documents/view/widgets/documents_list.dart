import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:paperless/app/features/documents/view/widgets/document_card.dart';
import 'package:paperless/exports.dart';

class DocumentsList extends StatelessWidget {
  const DocumentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final docs = context.select((DocumentsCubit state) => state.state.document);
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
            child: DocumentCard(doc),
          );
        },
      ),
    );
  }
}
