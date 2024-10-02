import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:paperless/exports.dart';

abstract interface class SessionManager extends ChangeNotifier {
  SessionManager();

  Session? activeSession;

  void updateUserInfo(UserModel user);

  void updateServerUri(Uri serverUri);

  void updateToken(String token);

  void checkSession();
}

@Named('SessionManager')
@LazySingleton(as: SessionManager)
final class SessionManagerImpl extends ValueNotifier<Session?>
    implements SessionManager {
  SessionManagerImpl() : super(null);

  @override
  Session? get activeSession => value;

  @override
  set activeSession(Session? activeSession) {
    value = activeSession;
  }

  @override
  void checkSession() {
    assert(activeSession != null, 'There is currently no active session');
  }

  @override
  void updateUserInfo(UserModel user) {
    checkSession();
    activeSession = activeSession!.copyWith(currentUser: user);
  }

  @override
  void updateServerUri(Uri serverUri) {
    checkSession();
    activeSession = activeSession!.copyWith(serverUri: serverUri);
  }

  @override
  void updateToken(String token) {
    checkSession();
    activeSession = activeSession!.copyWith(token: token);
  }
}
