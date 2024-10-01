import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
final class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.dateJoined,
    required this.isStaff,
    required this.isActive,
    required this.isSuperuser,
    required this.groups,
    required this.userPermissions,
    required this.inheritedPermissions,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? firstName;
  final String? lastName;
  final String? dateJoined;
  final bool? isStaff;
  final bool? isActive;
  final bool? isSuperuser;
  final List<String>? groups;
  final List<String>? userPermissions;
  final List<String>? inheritedPermissions;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        password,
        firstName,
        lastName,
        dateJoined,
        isStaff,
        isActive,
        isSuperuser,
        groups,
        userPermissions,
        inheritedPermissions,
      ];
}
