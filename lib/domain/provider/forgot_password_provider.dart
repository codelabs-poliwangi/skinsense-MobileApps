import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/utils/logger.dart';

class ForgotPasswordProvider {
  final ApiClient apiClient;
  ForgotPasswordProvider(this.apiClient);

  // email
  Future<void> forgotPassword({required String email}) async {
    try {
      final response = await apiClient.post(
        forgotPasswordUrl,
        data: {
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        logger.i('Success send OTP to email');
      }
    } on ApiException catch (e) {
      logger.e('Error Submit Email: $e');
      throw ApiException(message: e.data['message']);
    }
  }

  // Verify Token
  Future<void> verifyToken({required String token}) async {
    try {
      final response = await apiClient.post(
        verifyTokenUrl,
        data: {
          'token': token,
        },
      );

      if (response.statusCode == 200) {
        logger.i('Success Verify Token');
      }

      if (response.statusCode == 400) {
        logger.i('Failed Verify Token');
      }
    } on ApiException catch (e) {
      logger.e('Error verify OTP:  $e');
      throw ApiException(message: e.data['message']);
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
        resetPasswordUrl,
        data: {
          'token': token,
          'password': password,
          'confirmPassword': confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        logger.i('Success reset password');
      }
    } on ApiException catch (e) {
      logger.e('Error New Password: $e');
      throw ApiException(message: e.data['message']);
    }
  }

}
