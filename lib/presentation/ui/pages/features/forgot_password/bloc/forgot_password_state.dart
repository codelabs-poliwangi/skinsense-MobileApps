part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {

  const ForgotPasswordState();
  
  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}
final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordEmailSuccess extends ForgotPasswordState {
  final String email;

  const ForgotPasswordEmailSuccess({required this.email});

  @override
  List<Object> get props => [email];
}

final class ForgotPasswordOtpSuccess extends ForgotPasswordState {
  final String otp;

  const ForgotPasswordOtpSuccess({required this.otp});

  @override
  List<Object> get props => [otp];
}

final class ForgotPasswordResetSuccess extends ForgotPasswordState {
  final String token;
  final String password;
  final String confirmPassword;

  const ForgotPasswordResetSuccess({required this.token, required this.password, required this.confirmPassword});

  @override
  List<Object> get props => [token, password, confirmPassword];
}

final class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;

  const ForgotPasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}
