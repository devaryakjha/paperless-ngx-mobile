import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:paperless/exports.dart';

class BaseUrlInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final activeSession =
        getIt.get<SessionManager>(instanceName: 'SessionManager').activeSession;
    final request = activeSession != null
        ? chain.request.copyWith(baseUri: activeSession.serverUri)
        : chain.request;

    return chain.proceed(request);
  }
}
