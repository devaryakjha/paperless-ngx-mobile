// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'documents_cubit.dart';

final class DocumentsState extends Equatable {
  const DocumentsState({
    this.document = const [],
    this.fetchState = FetchState.initial,
  });

  final FetchState fetchState;
  final List<Document> document;

  @override
  List<Object> get props => [document, fetchState];

  DocumentsState copyWith({
    FetchState? fetchState,
    List<Document>? document,
  }) {
    return DocumentsState(
      fetchState: fetchState ?? this.fetchState,
      document: document ?? this.document,
    );
  }
}
