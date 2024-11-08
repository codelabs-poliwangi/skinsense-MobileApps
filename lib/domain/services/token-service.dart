import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  // Make the FlutterSecureStorage instance static
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Key used to store the token securely
  static const String _accessToken = 'access_token';
  static const String _refreshToken = 'refresh_token';

  // Save token securely (static method)
  static Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessToken, value: token);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshToken, value: token);
  }

  // Retrieve token securely (static method)
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessToken);
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshToken);
  }

  // Delete token securely (static method)
  static Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessToken);
  }

  static Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshToken);
  }
}
