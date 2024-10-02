import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paperless/exports.dart';

part 'session.g.dart';

@JsonSerializable()
final class Session extends Equatable {
  const Session({
    required this.token,
    required this.serverUri,
    required this.username,
    required this.password,
    this.user,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  final UserModel? user;
  final String token;
  @JsonKey(name: 'server')
  final Uri serverUri;
  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  @override
  List<Object?> get props => [user, token, serverUri];

  Session copyWith({
    UserModel? currentUser,
    String? token,
    Uri? serverUri,
    String? username,
    String? password,
  }) {
    return Session(
      user: currentUser ?? user,
      token: token ?? this.token,
      serverUri: serverUri ?? this.serverUri,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  String get uniqueId => '$username@$serverUri';
}
