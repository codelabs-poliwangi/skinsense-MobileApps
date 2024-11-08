import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  // Create an instance of FlutterSecureStorage
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Key used to store the token securely
  static const String _accesToken = 'access_token';
  static const String _refreshToken = 'refresh_token';

  // Save token securely

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accesToken, value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshToken, value: token);
  }

  // Retrieve token securely
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _accesToken);
  }
   Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshToken);
  }
  // Delete token securely
  Future<void> deleteAccessToken() async {
    await _storage.delete(key: _accesToken);
  }
  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: _refreshToken);
  }
}
