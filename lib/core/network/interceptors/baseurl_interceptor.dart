import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:paperless/exports.dart';

final class BaseurlInterceptor with SessionManagerMixin implements Interceptor {
  BaseurlInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final tag = chain.request.tag;
    if (tag is InterceptorTag) {
      final baseUrlTag = tag.find<BaseUrlTag>();
      if (baseUrlTag != null) {
        return chain.proceed(
          chain.request.copyWith(
            baseUri: cleanupServerUrl(baseUrlTag.baseUri),
          ),
        );
      }
    }
    final request = isUserLoggedIn
        ? chain.request.copyWith(
            baseUri: cleanupServerUrl(sessionManager.activeSession!.serverUri),
          )
        : chain.request;

    return chain.proceed(request);
  }
}
