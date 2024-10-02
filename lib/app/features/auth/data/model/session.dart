import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paperless/exports.dart';

part 'session.g.dart';

@JsonSerializable()
final class Session extends Equatable {
  const Session({
    required this.user,
    required this.token,
    required this.serverUri,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  final UserModel user;
  final String token;
  final Uri serverUri;

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  List<Object?> get props => [user, token, serverUri];

  Session copyWith({
    UserModel? currentUser,
    String? token,
    Uri? serverUri,
  }) {
    return Session(
      user: currentUser ?? user,
      token: token ?? this.token,
      serverUri: serverUri ?? this.serverUri,
    );
  }

  String get uniqueId => '${user.id}@$serverUri';
}
