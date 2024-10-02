import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:paperless/core/network/interceptors/baseurl_interceptor.dart';

@module
abstract class ChopperModule {
  @singleton
  ChopperClient get chopperClient {
    return ChopperClient(
      converter: const JsonConverter(),
      interceptors: [
        BaseurlInterceptor(),
      ],
    );
  }
}
