part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailSubmitted extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordEmailSubmitted({required this.email});

  @override
  List<Object> get props => [email];
}

class ForgotPasswordOtpSubmitted extends ForgotPasswordEvent {
  final String otp;

  const ForgotPasswordOtpSubmitted({required this.otp});

  @override
  List<Object> get props => [otp];
}