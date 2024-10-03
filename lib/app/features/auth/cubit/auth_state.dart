// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.sessions = const [],
    this.activeSession,
    this.status = AuthStatus.initial,
    this.serverValidated = false,
    this.errors = const [],
  });

  final List<Session> sessions;
  final Session? activeSession;
  final AuthStatus status;
  final bool serverValidated;
  final List<dynamic> errors;

  @override
  List<Object?> get props =>
      [sessions, activeSession, status, serverValidated, errors];

  AuthState copyWith({
    List<Session>? sessions,
    Session? activeSession,
    AuthStatus? status,
    bool? serverValidated,
    List<dynamic>? errors,
  }) {
    return AuthState(
      sessions: sessions ?? this.sessions,
      activeSession: activeSession ?? this.activeSession,
      status: status ?? this.status,
      serverValidated: serverValidated ?? this.serverValidated,
      errors: errors ?? this.errors,
    );
  }
}

enum AuthStatus {
  initial,
  checkingServer,
  authenticating,
  authenticated,
  error;

  bool get showLoading => this == checkingServer || this == authenticating;
}
