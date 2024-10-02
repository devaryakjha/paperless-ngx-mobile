import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:paperless/exports.dart';

final class AuthorizationInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) {
    if (chain.request.tag == noAuthorization) {
      return chain.proceed(chain.request);
    }
    final sessionManager = getIt<SessionManager>();
    if (sessionManager.activeSession != null) {
      final req = applyHeader(
        chain.request,
        HttpHeaders.authorizationHeader,
        'Token ${sessionManager.activeSession?.token ?? ''}',
      );

      return chain.proceed(req);
    }

    return chain.proceed(chain.request);
  }
}
