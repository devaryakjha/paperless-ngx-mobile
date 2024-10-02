import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paperless/exports.dart' show ConnectivityChecker, Session;

part 'auth_cubit.g.dart';
part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this._connectivityChecker) : super(const AuthState());

  final ConnectivityChecker _connectivityChecker;

  Future<void> validateServer(String serverUrl) async {
    final uri = Uri.parse('$serverUrl/api/');
    if (hasAlreadyCheckedServer(serverUrl)) return;
    emit(state.updateServerStatus(uri, ServerStatus.checking));
    final isReachable = await _connectivityChecker.isServerReachable(uri);
    final newState = state
        .updateServerStatus(
          uri,
          isReachable ? ServerStatus.reachable : ServerStatus.unreachable,
        )
        .copyWith(stage: AuthStage.initial);
    emit(newState);
  }

  bool hasAlreadyCheckedServer(String serverUrl) {
    final status = getServerStatus(serverUrl);
    return status != ServerStatus.initial;
  }

  ServerStatus getServerStatus(String serverUrl) {
    final uri = Uri.parse('$serverUrl/api/');
    return state.serverStatus[uri] ?? ServerStatus.initial;
  }

  bool isServerValid(String serverUrl) {
    final status = getServerStatus(serverUrl);
    return status == ServerStatus.reachable;
  }

  bool isServerChecking(String serverUrl) {
    final status = getServerStatus(serverUrl);
    return status == ServerStatus.checking;
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.toJson();
}
