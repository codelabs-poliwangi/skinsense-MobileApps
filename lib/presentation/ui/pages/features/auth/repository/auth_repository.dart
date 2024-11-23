import 'package:skinisense/domain/model/user.dart' as UserModel;
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/provider/authentication_provider.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/domain/services/token-service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:skinisense/domain/utils/logger.dart';

class AuthRepository {
  final ApiClient apiClient;
  final AuthenticationProvider authenticationProvider;
  final SharedPreferencesService sharedPreferencesService;
  final TokenService tokenService;
  AuthRepository(this.apiClient, this.authenticationProvider, this.tokenService,
      this.sharedPreferencesService);

  // Check if the user is logged in based on the token
  Future<bool> isLoggedIn() async {
    final token = await tokenService.getAccessToken();
    final username = await sharedPreferencesService.getString('name');
    return token != null && token.isNotEmpty && username!.isNotEmpty;
  }

  // Login method to authenticate the user and save credentials
  Future<UserModel.Data> login({
    required String email,
    required String password,
  }) async {
    try {
      // login via email dan password
      final user =
          await authenticationProvider.login(email: email, password: password);
      // After successful login, save the user credentials and token
      await saveUserCredentials(user);

      return user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String confirmPassword,
    required String password,
  }) async {
    try {
      final user = await authenticationProvider.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
        confirmPassword: confirmPassword,
      );
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }

  // Fetch the current authenticated user
  Future<UserModel.Data> me() async {
    try {
      final token = await tokenService.getAccessToken();
      if (token == null || token.isEmpty) {
        throw Exception('User is not logged in.');
      }
      return await authenticationProvider.me(token);
    } catch (e) {
      throw Exception('Failed to fetch user data: $e');
    }
  }

  // Save user credentials (token and user data)
  Future<void> saveUserCredentials(UserModel.Data user) async {
    try {
      // save credentials user -> user_id, name, email, phone
      await sharedPreferencesService.saveString('user_id', user.id);
      await sharedPreferencesService.saveString('name', user.name);
      await sharedPreferencesService.saveString('name', user.email);
      await sharedPreferencesService.saveString('name', user.phone);

      // save refresh and acces token
      await tokenService.saveAccessToken(
          'access_token'); // Replace with actual token from response
      await tokenService.saveRefreshToken(
          'refresh_token'); // Replace with actual refresh token
    } catch (e) {
      throw Exception('Failed to save user credentials: $e');
    }
  }

  // Logout method to clear user data
  Future<void> logout() async {
    // clear crendential user
    // clear sharePreferences -> save id nama
    // clear sharePreferences id user
    // clear sharePreferences nama user
    final token = await tokenService.getAccessToken();
    await authenticationProvider.logout(token!);
    await sharedPreferencesService.clearAllData();
    await tokenService.deleteAccessToken();
    await tokenService.deleteRefreshToken();
  }

  Future<firebaseAuth.UserCredential?> loginWithGoogle() async {
    try {
      final firebaseAuth.UserCredential response =
          await authenticationProvider.signInGoogle();
      if (response.additionalUserInfo != null) {
        //! 23-11-2024 kurang function to call back to server with jwt token, nanti akan mengembalikan acces_token dan refresh_token dari server
        // sharedPreferencesService.saveString('user_id', '');
        sharedPreferencesService.saveString(
            'name', response.user!.displayName!);
        sharedPreferencesService.saveString(
            'email', response.user!.email??" ");
        sharedPreferencesService.saveString(
            'phone', response.user!.phoneNumber??" ");
        
        logger.d('additiional User Info ${response.additionalUserInfo}');
        logger.d('credential user info ${response.credential}');
        logger.d('credential user info ${response.user}');
        logger.d('token jwt ${await response.user!.getIdToken()}');
        return response;
      }
    } catch (e) {
      throw Exception('Login Google failed: $e');
    }
    return null;
  }
}
