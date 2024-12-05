part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterStarted extends RegisterEvent {}

final class RegisterNameSubmitted extends RegisterEvent {
  final String name;

  const RegisterNameSubmitted({required this.name});

  @override
  List<Object> get props => [name];
}


final class RegisterContactSubmitted extends RegisterEvent {
  final String email;
  final String phone;

  const RegisterContactSubmitted(
    this.email,
    this.phone,
  );

  @override
  List<Object> get props => [email, phone];
}

final class RegisterPasswordSubmitted extends RegisterEvent {
  final String password;
  final String confirmPassword;

  const RegisterPasswordSubmitted(this.password, this.confirmPassword);

  @override
  List<Object> get props => [password, confirmPassword];
}