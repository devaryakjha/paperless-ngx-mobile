import 'dart:convert';

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

  void resetErrors() =>
      emit(state.copyWith(errors: [], status: AuthStatus.initial));

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
      final baseUrlTag = BaseUrlTag(Uri.parse(payload['server']!));
      emit(state.copyWith(status: AuthStatus.authenticating));
      final tokenRes = await _authService.signIn(payload, baseUrlTag);
      if (tokenRes.isSuccessful) {
        final token = tokenRes.body!;
        var session = Session.fromJson({
          ...payload,
          'token': token,
        });
        final user = await _userService.findCurrentUser(
          session.username,
          MultiTags([baseUrlTag, InjectTokenTag(session.token)]),
        );
        session = session.copyWith(currentUser: user.body);
        await _sessionManager.addSession(session, setAsactive: true);
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            activeSession: _sessionManager.activeSession,
            sessions: _sessionManager.sessions,
          ),
        );
      } else {
        final error =
            jsonDecode(tokenRes.error! as String) as Map<String, dynamic>;
        final messages = error['non_field_errors'] as List<dynamic>;
        emit(state.copyWith(status: AuthStatus.error, errors: messages));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error));
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
