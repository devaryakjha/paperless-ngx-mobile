// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.sessions = const [],
    this.activeSession,
    this.status = AuthStatus.initial,
  });

  final List<Session> sessions;
  final Session? activeSession;
  final AuthStatus status;

  @override
  List<Object?> get props => [sessions, activeSession, status];

  AuthState copyWith({
    List<Session>? sessions,
    Session? activeSession,
    AuthStatus? status,
  }) {
    return AuthState(
      sessions: sessions ?? this.sessions,
      activeSession: activeSession ?? this.activeSession,
      status: status ?? this.status,
    );
  }
}

enum AuthStatus {
  initial,
  checkingServer,
  serverValid,
  serverInvalid,
  authenticating,
  authenticated,
  error;

  bool get showLoading => this == checkingServer || this == authenticating;
  bool get serverValidated => ![
        AuthStatus.serverInvalid,
        AuthStatus.initial,
        AuthStatus.checkingServer,
      ].contains(this);
}
