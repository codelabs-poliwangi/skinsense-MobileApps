import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKeys {
  static const String userToken = 'user_token';
  static const String userData = 'user_data';
  static const String userEmail = 'user_email';
  static const String userPassword = 'user_password';
  static const String refreshToken = 'refresh_token';
}

class SecureStorage {
  final FlutterSecureStorage _storage;
  
  SecureStorage(): _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  // Write methods
  Future<void> writeSecureData(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> writeToken(String token) async {
    await writeSecureData(StorageKeys.userToken, token);
  }

  Future<void> writeRefreshToken(String token) async {
    await writeSecureData(StorageKeys.refreshToken, token);
  }

  Future<void> writeUserData(Map<String, dynamic> userData) async {
    await writeSecureData(StorageKeys.userData, jsonEncode(userData));
  }

  Future<void> writeCredentials({
    required String email,
    required String password,
  }) async {
    await writeSecureData(StorageKeys.userEmail, email);
    await writeSecureData(StorageKeys.userPassword, password);
  }

  // Read methods
  Future<String?> readSecureData(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (e) {
      debugPrint('Error reading secure data: $e');
      return null;
    }
  }

  Future<String?> readToken() async {
    return readSecureData(StorageKeys.userToken);
  }

  Future<String?> readRefreshToken() async {
    return readSecureData(StorageKeys.refreshToken);
  }

  Future<Map<String, dynamic>?> readUserData() async {
    try {
      final userDataStr = await readSecureData(StorageKeys.userData);
      if (userDataStr != null) {
        return jsonDecode(userDataStr) as Map<String, dynamic>;
      }
    } catch (e) {
      debugPrint('Error reading user data: $e');
    }
    return null;
  }

  Future<({String? email, String? password})> readCredentials() async {
    final email = await readSecureData(StorageKeys.userEmail);
    final password = await readSecureData(StorageKeys.userPassword);
    return (email: email, password: password);
  }

  // Delete methods
  Future<void> deleteSecureData(String key) async {
    await _storage.delete(key: key);
  }

  Future<void> deleteToken() async {
    await deleteSecureData(StorageKeys.userToken);
  }

  Future<void> deleteRefreshToken() async {
    await deleteSecureData(StorageKeys.refreshToken);
  }

  Future<void> deleteUserData() async {
    await deleteSecureData(StorageKeys.userData);
  }

  Future<void> deleteCredentials() async {
    await deleteSecureData(StorageKeys.userEmail);
    await deleteSecureData(StorageKeys.userPassword);
  }

  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  // Check methods
  Future<bool> hasToken() async {
    final token = await readToken();
    return token != null && token.isNotEmpty;
  }

  Future<bool> hasCredentials() async {
    final credentials = await readCredentials();
    return credentials.email != null && credentials.password != null;
  }
}