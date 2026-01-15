import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> storeLoginData(
    String accessToken,
    String refreshToken,
    String userId,
  ) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
    await _storage.write(key: 'userId', value: userId);
  }

  Future<bool> isLogin() async =>
      await _storage.read(key: 'accessToken') == null ? false : true;

  Future<String?> getAccessToken() async =>
      await _storage.read(key: 'accessToken');

  Future<String?> getRefreshToken() async =>
      await _storage.read(key: 'refreshToken');

  Future<void> clearAll() async => await _storage.deleteAll();
}
