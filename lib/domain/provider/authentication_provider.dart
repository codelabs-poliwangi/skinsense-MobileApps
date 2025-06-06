import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/user.dart' as UserModel;
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider {
  final ApiClient apiClient;

  AuthenticationProvider(this.apiClient);

  // Login method to authenticate the user
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiClient.post(
        loginUrl,
        data: {'email': email, 'password': password},
        requireAuth: false,
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        final refreshToken = response.data['refresh_token'];

        // Log token untuk debugging
        logger.d('Access token: $accessToken');
        logger.d('Refresh token: $refreshToken');

        // Fetch user data menggunakan access token
        final user = await me(accessToken);

        // Return user data bersama token
        return {
          'user': user,
          'access_token': accessToken,
          'refresh_token': refreshToken,
        };
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
        registerUrl,
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
  Future<UserModel.Data> me(String token) async {
    try {
      logger.d('fething to me');
      final response = await apiClient.get(
        meUrl,
        headers: {'Authorization': 'Bearer $token'},
        requireAuth: true,
      );
      logger.d(response.data);
      if (response.statusCode == 200) {
        // save credentials
        final user = UserModel.Data.fromJson(response.data);
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
        logoutUrl,
        headers: {'Authorization': 'Bearer $token'},
        requireAuth: true,
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

  Future<firebaseAuth.UserCredential> signInGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) throw Exception("Google sign-in was cancelled.");

      final googleAuth = await googleUser.authentication;

      final credential = firebaseAuth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final authResult = await firebaseAuth.FirebaseAuth.instance
          .signInWithCredential(credential);
      if (authResult.user == null) {
        throw Exception("Google sign-in failed: No user returned.");
      }
      logger.d('Authentication via google');
      return authResult;
    } catch (e) {
      throw Exception("Google sign-in failed: $e");
    }
  }

  Future<Map<String, dynamic>> getTokenAfterSignInGoogle(
    String jwtGoogle,
  ) async {
    try {
      final response = await apiClient.post(
        loginGoogleUrl,
        headers: {'Authorization': 'Bearer $jwtGoogle'},
        requireAuth: false,
      );
      if (response.statusCode == 200) {
        final accessToken = response.data['access_token'];
        final refreshToken = response.data['refresh_token'];

        // Log token untuk debugging
        logger.d('Access token: $accessToken');
        logger.d('Refresh token: $refreshToken');

        // Fetch user data menggunakan access token
        final user = await me(accessToken);

        // Return user data bersama token
        return {
          'user': user,
          'access_token': accessToken,
          'refresh_token': refreshToken,
        };
      } else {
        logger.e('Error: ${response.data['message']}');
        throw Exception('Failed to login: ${response.data['message']}');
      }
    } catch (e) {
      logger.e('Error get token after signin google: $e');
      throw Exception('Failed to login: $e');
    }
  }

  // refreshToken
  Future<ApiResponse<dynamic>> generateAccesToken(String refreshToken) async {
    try {
      final response = await apiClient.post(
        refreshTokenUrl,
        requireAuth: false,
        isSkipInspector: true,
        data: {"refresh_token": refreshToken},
      );

      return response;
    } catch (e) {
      logger.e('Logout error: $e');
      throw Exception('Failed to logout: $e');
    }
  }
}
