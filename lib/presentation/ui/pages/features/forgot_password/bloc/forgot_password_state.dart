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

final class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;

  const ForgotPasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}
