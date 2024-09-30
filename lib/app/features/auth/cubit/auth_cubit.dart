import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paperless/exports.dart' show AuthFormData, ConnectivityChecker;

part 'auth_cubit.g.dart';
part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.connectivityChecker) : super(const AuthState());

  final ConnectivityChecker connectivityChecker;

  Future<void> signIn(AuthFormData data) async {
    try {
      emit(state.copyWith(stage: AuthStage.loading));
      final isServerReachable =
          await connectivityChecker.isPaperlessServerReachable(data.serverUrl);

      if (!isServerReachable) {
        emit(state.copyWith(stage: AuthStage.failure));
        return;
      }

      // TODO: Use api chopper service
      emit(state.copyWith(stage: AuthStage.success));
    } catch (e) {
      emit(state.copyWith(stage: AuthStage.failure));
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.toJson();
}
