import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paperless/exports.dart';

part 'session.g.dart';

@JsonSerializable()
final class Session extends Equatable {
  const Session({
    required this.currentUser,
    required this.token,
    required this.serverUri,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  final UserModel currentUser;
  final String token;
  final Uri serverUri;

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  List<Object?> get props => [currentUser, token, serverUri];

  Session copyWith({
    UserModel? currentUser,
    String? token,
    Uri? serverUri,
  }) {
    return Session(
      currentUser: currentUser ?? this.currentUser,
      token: token ?? this.token,
      serverUri: serverUri ?? this.serverUri,
    );
  }
}
