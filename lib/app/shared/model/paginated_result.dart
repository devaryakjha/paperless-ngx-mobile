// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'paginated_result.g.dart';

@JsonSerializable(genericArgumentFactories: true)
final class PaginatedResult<T extends Equatable> extends Equatable {
  const PaginatedResult({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  factory PaginatedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$PaginatedResultFromJson<T>(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T) toJsonT) =>
      _$PaginatedResultToJson(this, toJsonT);

  /// Total number of available items
  final int count;

  /// Link to next page
  final String? next;

  /// Link to previous page
  final String? previous;

  /// List of items
  final List<T> results;

  @override
  List<Object?> get props => [results, count, next, previous];

  PaginatedResult<T> copyWith({
    int? count,
    String? next,
    String? previous,
    List<T>? results,
  }) {
    return PaginatedResult<T>(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}
