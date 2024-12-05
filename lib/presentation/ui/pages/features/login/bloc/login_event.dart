part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted({
    required this.email,
    required this.password
  });

  List<Object?> get props => [email, password];
}
class LoginWithGoogleEvent extends LoginEvent{

}
