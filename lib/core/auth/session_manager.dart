import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:paperless/core/storage/secure_storage.dart';
import 'package:paperless/exports.dart';

@singleton
final class SessionManager {
  SessionManager(
    this._secureStorage, [
    this._sessions = const [],
    this.activeSession,
  ]);

  final SecureStorage _secureStorage;

  Session? activeSession;

  final List<Session> _sessions;

  @FactoryMethod(preResolve: true)
  static Future<SessionManager> init(SecureStorage secureStorage) async {
    final sessionJson = await secureStorage.read('sessions');
    final sessionList =
        sessionJson != null ? jsonDecode(sessionJson) as List : <dynamic>[];
    final sessions = sessionList
        .map((s) => Session.fromJson(Map<String, dynamic>.from(s as Map)))
        .toList();

    final currentSessionId = await secureStorage.read('current_session_id');
    final currentSession = currentSessionId != null
        ? sessions.firstWhere((s) => s.uniqueId == currentSessionId)
        : null;
    return SessionManager(secureStorage, sessions, currentSession);
  }

  Future<void> addSession(Session session) async {
    _sessions.add(session);
    await _saveSessions();
  }

  Future<void> setActiveSession(Session session) async {
    activeSession = session;
    await _secureStorage.write(
      key: 'current_session_id',
      value: session.uniqueId,
    );
  }

  Future<void> removeSession(Session session) async {
    _sessions.remove(session);
    await _saveSessions();
  }

  List<Session> get sessions => _sessions;

  List<UserModel> get users => _sessions.map((s) => s.user).toList();

  UserModel? get currentUser => activeSession?.user;

  Future<void> _saveSessions() async {
    await _secureStorage.write(
      key: 'sessions',
      value: jsonEncode(_sessions),
    );
  }
}
