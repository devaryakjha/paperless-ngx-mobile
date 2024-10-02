// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: (json['id'] as num?)?.toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      dateJoined: json['date_joined'] as String?,
      isStaff: json['is_staff'] as bool?,
      isActive: json['is_active'] as bool?,
      isSuperuser: json['is_superuser'] as bool?,
      groups:
          (json['groups'] as List<dynamic>?)?.map((e) => e as String).toList(),
      userPermissions: (json['user_permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      inheritedPermissions: (json['inherited_permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'date_joined': instance.dateJoined,
      'is_staff': instance.isStaff,
      'is_active': instance.isActive,
      'is_superuser': instance.isSuperuser,
      'groups': instance.groups,
      'user_permissions': instance.userPermissions,
      'inherited_permissions': instance.inheritedPermissions,
    };
