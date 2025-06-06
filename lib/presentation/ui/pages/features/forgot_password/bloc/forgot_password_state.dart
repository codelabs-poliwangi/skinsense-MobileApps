part of 'forgot_password_bloc.dart';

enum ForgotPasswordStatus { initial, loading, emailSuccess, otpSuccess, resetSuccess, failure }

final class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.email = '',
    this.otp = '',
    this.token = '',
    this.password = '',
    this.confirmPassword = '',
    this.error = '',
  });

  final ForgotPasswordStatus status;
  final String email;
  final String otp;
  final String token;
  final String password;
  final String confirmPassword;
  final String error;

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    String? email,
    String? otp,
    String? token,
    String? password,
    String? confirmPassword,
    String? error,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      email: email ?? this.email,
      otp: otp ?? this.otp,
      token: token ?? this.token,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, email, otp, token, password, confirmPassword, error];
}
