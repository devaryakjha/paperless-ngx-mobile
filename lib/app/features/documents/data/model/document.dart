import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document.g.dart';

@JsonSerializable()
final class Document extends Equatable {
  const Document({
    required this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.documentType,
    required this.correspondent,
    required this.storagePath,
    required this.created,
    required this.modified,
    required this.added,
    required this.archiveSerialNumber,
    required this.originalFileName,
    required this.archivedFileName,
    required this.owner,
    required this.userCanChange,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  final int id;
  final String title;
  final String? content;
  final Iterable<int> tags;
  final int? documentType;
  final int? correspondent;
  final int? storagePath;
  final DateTime created;
  final DateTime modified;
  final DateTime added;
  final int? archiveSerialNumber;
  final String? originalFileName;
  final String? archivedFileName;
  final int? owner;
  final bool? userCanChange;

  Map<String, dynamic> toJson() => _$DocumentToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        tags,
        documentType,
        correspondent,
        storagePath,
        created,
        modified,
        added,
        archiveSerialNumber,
        originalFileName,
        archivedFileName,
        owner,
        userCanChange,
      ];

  String get thumbUrl => 'documents/$id/thumb/';
}
