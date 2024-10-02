import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:paperless/exports.dart';

final class BaseurlInterceptor implements Interceptor {
  BaseurlInterceptor();

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final sessionManager = getIt<SessionManager>();
    final request = sessionManager.activeSession != null
        ? chain.request.copyWith(
            baseUri: sessionManager.activeSession!.serverUri,
          )
        : chain.request;

    return chain.proceed(request);
  }
}
