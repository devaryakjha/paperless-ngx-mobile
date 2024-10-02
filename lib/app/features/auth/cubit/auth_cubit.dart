import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paperless/exports.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._sessionManager, this._connectivityChecker)
      : super(const AuthState());

  final SessionManager _sessionManager;
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
}
