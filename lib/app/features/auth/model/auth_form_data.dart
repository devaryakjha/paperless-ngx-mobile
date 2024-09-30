import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_form_data.g.dart';

@JsonSerializable()
final class AuthFormData extends Equatable {
  const AuthFormData({
    required this.serverUrl,
    required this.username,
    required this.password,
  });

  factory AuthFormData.fromJson(Map<String, dynamic> json) =>
      _$AuthFormDataFromJson(json);

  final String serverUrl;
  final String username;
  final String password;

  Map<String, dynamic> toJson() => _$AuthFormDataToJson(this);

  @override
  List<Object?> get props => [serverUrl, username, password];
}
