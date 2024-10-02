import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

part 'auth_service.chopper.g.dart';

@singleton
@ChopperApi()
abstract class AuthService extends ChopperService {
  @factoryMethod
  static AuthService create(ChopperClient client) => _$AuthService(client);
}
