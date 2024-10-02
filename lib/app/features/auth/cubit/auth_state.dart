// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@JsonSerializable()
final class AuthState extends Equatable {
  const AuthState({
    this.stage = AuthStage.initial,
    this.session,
    this.serverStatus = const {},
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  final AuthStage stage;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Map<Uri, ServerStatus> serverStatus;
  final Session? session;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);

  @override
  List<Object?> get props => [stage, session, serverStatus];

  AuthState copyWith({
    AuthStage? stage,
    Session? session,
    Map<Uri, ServerStatus>? serverStatus,
  }) {
    return AuthState(
      stage: stage ?? this.stage,
      session: session ?? this.session,
      serverStatus: serverStatus ?? this.serverStatus,
    );
  }

  AuthState updateServerStatus(Uri uri, ServerStatus status) {
    final newServerStatus = Map<Uri, ServerStatus>.from(serverStatus)
      ..[uri] = status;
    return copyWith(serverStatus: newServerStatus);
  }
}

enum AuthStage {
  initial,
  loading,
  success,
  failure;

  bool get isLoading => this == loading;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}

enum ServerStatus {
  initial,
  checking,
  reachable,
  unreachable;

  bool get isInitial => this == initial;
  bool get isChecking => this == checking;
  bool get isReachable => this == reachable;
  bool get isUnreachable => this == unreachable;
}
