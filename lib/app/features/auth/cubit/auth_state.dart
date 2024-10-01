// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@JsonSerializable()
final class AuthState extends Equatable {
  const AuthState({
    this.stage = AuthStage.initial,
    this.session,
  });

  @JsonKey(includeFromJson: false, includeToJson: false)
  final AuthStage stage;
  final Session? session;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);

  @override
  List<Object?> get props => [stage, session];
}

enum AuthStage {
  initial,
  loading,
  serverValid,
  serverInvalid,
  success,
  failure;

  bool get isLoading => this == loading;
  bool get isServerValid => this == serverValid;
  bool get isServerInvalid => this == serverInvalid;
  bool get isSuccess => this == success;
  bool get isFailure => this == failure;
}
