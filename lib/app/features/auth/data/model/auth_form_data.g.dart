// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthFormData _$AuthFormDataFromJson(Map<String, dynamic> json) => AuthFormData(
      serverUrl: json['server_url'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthFormDataToJson(AuthFormData instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
