import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:paperless/exports.dart';

part 'auth_service.chopper.g.dart';

@singleton
@ChopperApi()
abstract class AuthService extends ChopperService {
  @factoryMethod
  static AuthService create(ChopperClient client) => _$AuthService(client);

  @FactoryConverter(response: _createReponse)
  @Post(path: 'token/')
  Future<Response<String>> signIn(
    @Body() Map<String, String> payload,
    @Tag() BaseUrlTag baseUrl,
  );
}

Response<String> _createReponse(Response<dynamic> res) {
  return res.copyWith(
    body: Map<String, dynamic>.from(jsonDecode(res.bodyString) as Map)['token']
        as String,
  );
}
