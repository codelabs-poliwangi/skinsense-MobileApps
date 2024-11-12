import 'package:skinisense/domain/model/user_model.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/services/token-service.dart';

class AuthProvider {
  final ApiClient apiClient = ApiClient();
  AuthProvider();

  // Login method to authenticate the user
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final user = await me(response.data['access_token']);
        return user;
      } else {
        throw Exception('Failed to login: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // Login method to authenticate the user
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await apiClient.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
          'confirm_password': confirmPassword,
        },
      );

      if (response.statusCode == 201) {
        print("Message: ${response.message}");
      } else {
        throw Exception('Failed to Register: ${response.message}');
      }
    } catch (e) {
      throw Exception('Failed to Register: $e');
    }
  }

  Future<User> me(String token) async {
    try {
  
      final response = await apiClient.get(
        '/user/me',
        headers: {
          'Authorization': "Bearer $token" 
        }
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        return user;
      } else {
        throw Exception('Failed to Auth: $response');
      }
    } catch (e) {
      throw Exception('Failed to Auth: $e');
    }
  }
  Future<void> logout(String token) async {
    try {
      final response = await apiClient.post(
        '/logout', // Your API endpoint for logging out
        headers: {
          'Authorization': "Bearer $token", // Pass the token for invalidation
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to logout: ${response.data['message']}');
      }
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }
}
