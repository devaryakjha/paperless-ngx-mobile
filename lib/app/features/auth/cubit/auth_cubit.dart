import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paperless/exports.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._sessionManager, this._connectivityChecker, this._authService)
      : super(const AuthState());

  final SessionManager _sessionManager;
  final AuthService _authService;
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
    emit(state.copyWith(status: AuthStatus.authenticating));
    emit(state.copyWith(status: AuthStatus.initial));
  }
}
