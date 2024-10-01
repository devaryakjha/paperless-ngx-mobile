import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:paperless/exports.dart' show UserModel;

part 'auth_service.chopper.dart';

@ChopperApi()
abstract class AuthService extends ChopperService {
  static AuthService create([ChopperClient? client]) => _$AuthService(client);

  @Post(path: '/token/')
  Future<Response<dynamic>> signIn(@body Map<String, String> data);

  @FactoryConverter(
    response: createResponse,
  )
  @Get(path: '/users/')
  Future<Response<UserModel>> findUser(
    @Query('username__iexact') String username,
    @Header('Authorization') String token,
  );
}

FutureOr<Response<UserModel>> createResponse(Response<dynamic> response) {
  final json = jsonDecode(response.bodyString);
  final resultsList = json['results'] as List;
  final userJson = resultsList.first as Map<String, dynamic>;
  return response.copyWith<UserModel>(body: UserModel.fromJson(userJson));
}
