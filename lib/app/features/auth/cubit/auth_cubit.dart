import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paperless/exports.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
    this._sessionManager,
    this._connectivityChecker,
    this._authService,
    this._userService,
  ) : super(const AuthState());

  final SessionManager _sessionManager;
  final AuthService _authService;
  final UserService _userService;
  final ConnectivityChecker _connectivityChecker;

  Future<void> init() async {
    final sessions = _sessionManager.sessions;
    final activeSession = _sessionManager.activeSession;
    emit(
      state.copyWith(
        status: activeSession != null
            ? AuthStatus.authenticated
            : AuthStatus.initial,
        sessions: sessions,
        activeSession: activeSession,
      ),
    );
  }

  void resetStatus() => emit(state.copyWith(serverValidated: false));

  Future<void> checkServer(String server, [VoidCallback? onError]) async {
    emit(state.copyWith(status: AuthStatus.checkingServer));
    final serverUri = Uri.parse(server);
    final isValid = await _connectivityChecker.isServerReachable(serverUri);
    if (!isValid) {
      onError?.call();
      emit(state.copyWith(status: AuthStatus.initial, serverValidated: false));
      return;
    }
    emit(state.copyWith(status: AuthStatus.initial, serverValidated: true));
  }

  Future<void> signIn(Map<String, String> payload) async {
    try {
      emit(state.copyWith(status: AuthStatus.authenticating));
      var session = Session.fromJson({...payload, 'token': ''});
      await _sessionManager.addSession(session, setAsactive: true);
      final token = await _authService.signIn(payload);
      session = session.copyWith(token: token.body);
      await _sessionManager.addSession(session, setAsactive: true);
      final user = await _userService.findCurrentUser(session.username);
      session = session.copyWith(currentUser: user.body);
      await _sessionManager.updateSession(session);
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          activeSession: _sessionManager.activeSession,
          sessions: _sessionManager.sessions,
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> signout() async {
    await _sessionManager.removeSession(_sessionManager.activeSession!);
    emit(
      AuthState(
        sessions: _sessionManager.sessions,
        activeSession: _sessionManager.activeSession,
      ),
    );
  }
}
