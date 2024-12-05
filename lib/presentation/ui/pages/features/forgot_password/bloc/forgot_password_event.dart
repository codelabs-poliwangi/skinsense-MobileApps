part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailSubmitted extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordEmailSubmitted(this.email);

  @override
  List<Object> get props => [email];
}

class ForgotPasswordOtpSubmitted extends ForgotPasswordEvent {
  final String otp;

  const ForgotPasswordOtpSubmitted({required this.otp});

  @override
  List<Object> get props => [otp];
}

class ForgotPasswordResetSubmitted extends ForgotPasswordEvent {
  final String token;
  final String password;
  final String confirmPassword;

  const ForgotPasswordResetSubmitted({
    required this.token,
    required this.password,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [token, password, confirmPassword];
}