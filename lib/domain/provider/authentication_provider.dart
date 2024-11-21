import 'package:skinisense/domain/model/user_model.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/utils/logger.dart';

class AuthenticationProvider {
  final ApiClient apiClient;

  AuthenticationProvider(this.apiClient);

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
        logger.e('Error: ${response.data['message']}');
        throw Exception('Failed to login: ${response.data['message']}');
      }
    } catch (e) {
      logger.e('Login error: $e');
      throw Exception('Failed to login: $e');
    }
  }

  // Register method to create a new user
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
        logger.i('Registration successful: ${response.data['message']}');
      } else {
        logger.e('Error: ${response.data['message']}');
        throw Exception('Failed to register: ${response.data['message']}');
      }
    } catch (e) {
      logger.e('Register error: $e');
      throw Exception('Failed to register: $e');
    }
  }

  // Fetch current user details
  Future<User> me(String token) async {
    try {
      final response = await apiClient.get(
        '/auth/me',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final user = User.fromJson(response.data);
        return user;
      } else {
        logger.e('Error fetching user: ${response.data}');
        throw Exception('Failed to authenticate user');
      }
    } catch (e) {
      logger.e('Error in me(): $e');
      throw Exception('Failed to fetch user details: $e');
    }
  }

  // Logout method
  Future<void> logout(String token) async {
    try {
      final response = await apiClient.post(
        '/auth/logout',
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode != 200) {
        logger.e('Error: ${response.data['message']}');
        throw Exception('Failed to logout: ${response.data['message']}');
      }
      logger.i('User logged out successfully');
    } catch (e) {
      logger.e('Logout error: $e');
      throw Exception('Failed to logout: $e');
    }
  }
}
