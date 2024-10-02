import 'dart:async';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:paperless/exports.dart';

final class AuthInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
    Chain<BodyType> chain,
  ) async {
    final activeSession =
        getIt.get<SessionManager>(instanceName: 'SessionManager').activeSession;

    if (activeSession != null) {
      final request = applyHeader(
        chain.request,
        HttpHeaders.authorizationHeader,
        'Token ${activeSession.token}',
        override: false,
      );

      final response = await chain.proceed(request);

      if (response.statusCode == 401) {
        getIt
            .get<SessionManager>(instanceName: 'SessionManager')
            .activeSession = null;
        // TODO: Add an authenticator to refresh the token
      }

      return response;
    }

    return chain.proceed(chain.request);
  }
}
