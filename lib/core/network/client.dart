import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:paperless/core/network/interceptors/authenticator.dart';
import 'package:paperless/core/network/interceptors/based_url.dart';

@module
abstract class ChopperModule {
  @Named('client')
  @lazySingleton
  ChopperClient get chopperClient {
    return ChopperClient(
      converter: const JsonConverter(),
      interceptors: [
        BaseUrlInterceptor(),
        AuthInterceptor(),
      ],
    );
  }
}
