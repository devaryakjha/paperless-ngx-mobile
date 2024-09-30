// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthState _$AuthStateFromJson(Map<String, dynamic> json) => AuthState(
      stage: $enumDecodeNullable(_$AuthStageEnumMap, json['stage']) ??
          AuthStage.initial,
      serverUrl: json['server_url'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$AuthStateToJson(AuthState instance) => <String, dynamic>{
      'stage': _$AuthStageEnumMap[instance.stage]!,
      'server_url': instance.serverUrl,
      'token': instance.token,
    };

const _$AuthStageEnumMap = {
  AuthStage.initial: 'initial',
  AuthStage.loading: 'loading',
  AuthStage.success: 'success',
  AuthStage.failure: 'failure',
};
