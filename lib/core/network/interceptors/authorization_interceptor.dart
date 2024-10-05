import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:paperless/exports.dart';

final class AuthorizationInterceptor
    with SessionManagerMixin
    implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    final tag = chain.request.tag as InterceptorTag?;
    final noAuth = tag?.find<NoAuthorizationTag>() != null;

    if (noAuth) {
      return chain.proceed(chain.request);
    }

    String? token;
    final injectToken = tag?.find<InjectTokenTag>();

    if (injectToken != null) {
      token = injectToken.token;
    } else {
      final session = sessionManager.activeSession;
      token = session?.token;
    }

    if (token != null && token.isNotEmpty) {
      final req = applyHeader(
        chain.request,
        HttpHeaders.authorizationHeader,
        'Token $token',
      );

      return chain.proceed(req);
    }

    return chain.proceed(chain.request);
  }
}
