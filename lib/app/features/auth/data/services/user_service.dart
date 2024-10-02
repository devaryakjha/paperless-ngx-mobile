import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:paperless/exports.dart';

part 'user_service.chopper.g.dart';

@singleton
@ChopperApi()
abstract class UserService extends ChopperService {
  @factoryMethod
  static UserService create(ChopperClient client) => _$UserService(client);

  @FactoryConverter(
    response: _createReponse,
  )
  @Get(path: 'users/')
  Future<Response<UserModel>> findCurrentUser(
    @Query('username__iexact') String username,
  );
}

Response<UserModel> _createReponse(Response<dynamic> res) {
  final json = jsonDecode(res.body as String) as Map<String, dynamic>;
  final results = json['results'] as List;
  if (results.isEmpty) {
    throw Exception('User not found');
  }
  return res.copyWith(
    body: UserModel.fromJson(results.first as Map<String, dynamic>),
  );
}
