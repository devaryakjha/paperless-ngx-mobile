import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@singleton
final class SecureStorage {
  const SecureStorage(this._encryptionBox);

  final Box<String> _encryptionBox;

  @FactoryMethod(preResolve: true)
  static Future<SecureStorage> init() async {
    const secureStorage = FlutterSecureStorage();
    List<int> encryptionKey;
    final containsEncryptionKey = await secureStorage.containsKey(
      key: 'encryptionKey',
    );
    if (!containsEncryptionKey) {
      encryptionKey = Hive.generateSecureKey();
      await secureStorage.write(
        key: 'encryptionKey',
        value: base64UrlEncode(encryptionKey),
      );
    } else {
      encryptionKey =
          base64Decode((await secureStorage.read(key: 'encryptionKey'))!);
    }

    final encryptionBox = await Hive.openBox<String>(
      'encryptedBox',
      encryptionCipher: HiveAesCipher(encryptionKey),
    );

    return SecureStorage(encryptionBox);
  }

  Future<void> write({
    required String key,
    required String value,
  }) async {
    await _encryptionBox.put(key, value);
  }

  Future<String?> read(String key) async {
    return _encryptionBox.get(key);
  }

  Future<void> delete(String key) async {
    await _encryptionBox.delete(key);
  }

  Future<void> clear() async {
    await _encryptionBox.clear();
  }

  Future<void> deleteAll() async {
    await _encryptionBox.deleteFromDisk();
  }

  @disposeMethod
  Future<void> close() async {
    await _encryptionBox.close();
  }
}
