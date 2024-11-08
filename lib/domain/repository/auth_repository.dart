import 'package:skinisense/domain/model/user_model.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/provider/auth_provider.dart';
import 'package:skinisense/domain/services/token-service.dart';

class AuthRepository {
  final ApiClient apiClient = ApiClient();
  final AuthProvider authProvider = AuthProvider();

  AuthRepository();

  // Check if the user is logged in based on the token
  Future<bool> isLoggedIn() async {
    final token = await TokenService.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Login method to authenticate the user and save credentials
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authProvider.login(email: email, password: password);
      // After successful login, save the user credentials and token
      await saveUserCredentials();
      
      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  // Fetch the current authenticated user
  Future<User> me() async {
    try {
      final token = await TokenService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('User is not logged in.');
      }
      return await authProvider.me(token);
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }

  // Save user credentials (token and user data)
  Future<void> saveUserCredentials() async {
    try {
      await TokenService.saveAccessToken('access_token');  // Replace with actual token from response
      await TokenService.saveRefreshToken('refresh_token');  // Replace with actual refresh token
    } catch (e) {
      throw Exception('Failed to save user credentials: $e');
    }
  }

  // Logout method to clear user data
  Future<void> logout() async {
    final token = await TokenService.getAccessToken();
    await authProvider.logout(token!);
    await TokenService.deleteAccessToken();
    await TokenService.deleteRefreshToken();

  }
}
