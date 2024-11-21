import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:skinisense/domain/model/user_model.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/provider/authentication_provider.dart';
import 'package:skinisense/domain/services/token-service.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthRepository {
  final ApiClient apiClient;
  final AuthenticationProvider authenticationProvider;
  final TokenService tokenService;
  AuthRepository(this.apiClient, this.authenticationProvider, this.tokenService);

  // Check if the user is logged in based on the token
  Future<bool> isLoggedIn() async {
    final token = await tokenService.getAccessToken();
    return token != null && token.isNotEmpty;
  }

  // Login method to authenticate the user and save credentials
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await authenticationProvider.login(email: email, password: password);
      // After successful login, save the user credentials and token
      await saveUserCredentials();
      
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
        confirmPassword: confirmPassword
      );
    } catch (e) {
      throw Exception('Register failed: $e');
    }
  }

  // Fetch the current authenticated user
  Future<User> me() async {
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
  Future<void> saveUserCredentials() async {
    try {
      await tokenService.saveAccessToken('access_token');  // Replace with actual token from response
      await tokenService.saveRefreshToken('refresh_token');  // Replace with actual refresh token
    } catch (e) {
      throw Exception('Failed to save user credentials: $e');
    }
  }

  // Logout method to clear user data
  Future<void> logout() async {
    final token = await tokenService.getAccessToken();
    await authenticationProvider.logout(token!);
    await tokenService.deleteAccessToken();
    await tokenService.deleteRefreshToken();

  }
  
Future<firebaseAuth.User?> loginWithGoogle() async {
  try {
    // Start the sign-in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      // Authenticate with Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential for Firebase
      final firebaseAuth.AuthCredential credential = firebaseAuth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final firebaseAuth.UserCredential authResult =
          await firebaseAuth.FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.user != null) {
        // Successfully signed in, return the Firebase user
        return authResult.user;
      } else {
        throw Exception("Google sign-in failed: No user returned.");
      }
    } else {
      throw Exception("Google sign-in was cancelled.");
    }
  } catch (e) {
    // Handle errors during the login process
    throw Exception("Google sign-in failed: $e");
  }
}
}
