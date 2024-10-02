import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ChopperModule {
  @Named('client')
  @lazySingleton
  ChopperClient get chopperClient {
    return ChopperClient(
      converter: const JsonConverter(),
      interceptors: [],
    );
  }
}
