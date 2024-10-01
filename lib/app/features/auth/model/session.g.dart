// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      currentUser:
          UserModel.fromJson(json['current_user'] as Map<String, dynamic>),
      token: json['token'] as String,
      serverUri: Uri.parse(json['server_uri'] as String),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'current_user': instance.currentUser.toJson(),
      'token': instance.token,
      'server_uri': instance.serverUri.toString(),
    };
