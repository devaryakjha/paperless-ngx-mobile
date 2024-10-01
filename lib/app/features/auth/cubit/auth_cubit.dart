import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:paperless/exports.dart' show ConnectivityChecker, Session;

part 'auth_cubit.g.dart';
part 'auth_state.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit(this.connectivityChecker) : super(const AuthState());

  final ConnectivityChecker connectivityChecker;
  // late AuthService authService;
  // late ChopperClient chopperClient;

  // Future<void> signIn(AuthFormData data) async {
  //   try {
  //     emit(state.copyWith(stage: AuthStage.loading));
  //     final isServerReachable =
  //         await connectivityChecker.isPaperlessServerReachable(data.serverUrl);

  //     if (!isServerReachable) {
  //       emit(state.copyWith(stage: AuthStage.failure));
  //       return;
  //     }

  //     chopperClient = ChopperClient(
  //       baseUrl: Uri.parse('${data.serverUrl}/api'),
  //       services: [AuthService.create()],
  //     );

  //     authService = chopperClient.getService<AuthService>();

  //     final response = await authService.signIn(data.toJson());
  //     final token = (jsonDecode(response.bodyString) as Map)['token'] as String;
  //     final user =
  //         (await authService.findUser(data.username, 'Token $token')).body;

  //     emit(
  //       state.copyWith(
  //         stage: AuthStage.success,
  //         token: token,
  //         serverUrl: data.serverUrl,
  //         user: user,
  //       ),
  //     );

  //     // TODO(Arya): save the credentials to the secure storage
  //   } catch (e) {
  //     emit(state.copyWith(stage: AuthStage.failure));
  //   }
  // }

  void restoreSession() {}

  @override
  AuthState? fromJson(Map<String, dynamic> json) => AuthState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthState state) => state.toJson();
}
