import 'package:skinisense/domain/model/user_model.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/utils/logger.dart';

class ForgotPasswordProvider {
  final ApiClient apiClient;
  ForgotPasswordProvider(this.apiClient);

  // email
  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await apiClient.post(
        '/auth/forgot-password',
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        logger.i('Success send OTP to email');
      }
    } catch (e) {
      logger.e('error = $e');
      throw Exception('Failed to login: $e');
    }
  }

  // Verify Token
  Future<void> verifyToken({required String token}) async {
    try {
      final response = await apiClient.post(
        '/auth/verify-token',
        data: {
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        logger.i('Success Verify Token');
      }
    } catch (e) {
      logger.e('error = $e');
      throw Exception('Failed to login: $e');
    }
  }

    // email
  Future<void> resetPassword({
      required String token,
      required String password,
      required String confirmPassword,
    }) async {
    try {
      final response = await apiClient.post(
        '/auth/reset-password',
        data: {
          'token': token,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        logger.i('Success reset password');
      }
    } catch (e) {
      logger.e('error = $e');
      throw Exception('Failed to login: $e');
    }
  }

}
