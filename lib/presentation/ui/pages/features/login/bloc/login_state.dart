part of 'login_bloc.dart';

@immutable
sealed class LoginState {
  const LoginState();

  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User.Data user;
  
  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;
  const LoginFailure(this.error);
}

class LoginWithGoogleIntial extends LoginState{}
class LoginWithGoogleLoading extends LoginState{}
class LoginWithGoogleSuccess extends LoginState {
  final User.Data user;

  const LoginWithGoogleSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginWithGoogleError extends LoginState {
  final String? error;

  const LoginWithGoogleError([this.error]);

  @override
  List<Object?> get props => [error];
}
