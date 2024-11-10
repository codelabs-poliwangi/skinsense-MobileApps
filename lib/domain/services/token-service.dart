import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  // Make the FlutterSecureStorage instance
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Key used to store the token securely
  static const String _accessToken = 'access_token';
  static const String _refreshToken = 'refresh_token';

  // Save token securely ( method)
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessToken, value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshToken, value: token);
  }

  // Retrieve token securely ( method)
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessToken);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshToken);
  }

  // Delete token securely ( method)
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accessToken);
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshToken);
  }
}
