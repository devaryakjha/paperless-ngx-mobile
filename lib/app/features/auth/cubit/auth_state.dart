// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@JsonSerializable()
final class AuthState extends Equatable {
  const AuthState({
    this.stage = AuthStage.initial,
    this.serverUrl,
    this.token,
    this.user,
  });

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  final AuthStage stage;
  final String? serverUrl;
  final String? token;
  final UserModel? user;

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);

  @override
  List<Object?> get props => [stage, serverUrl, token];

  AuthState copyWith({
    AuthStage? stage,
    String? serverUrl,
    String? token,
    UserModel? user,
  }) {
    return AuthState(
      stage: stage ?? this.stage,
      serverUrl: serverUrl ?? this.serverUrl,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}

@JsonEnum()
enum AuthStage {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == AuthStage.loading;
  bool get isSuccess => this == AuthStage.success;
  bool get isFailure => this == AuthStage.failure;
}
