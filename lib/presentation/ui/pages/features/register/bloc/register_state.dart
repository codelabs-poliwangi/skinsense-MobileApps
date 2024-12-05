part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String? error;
  final RegisterStatus status;

  const RegisterState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.error,
    this.status = RegisterStatus.initial,
  });

  RegisterState copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? error,
    RegisterStatus? status,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        password,
        confirmPassword,
        isLoading,
        error,
        status,
      ];
}

enum RegisterStatus {
  initial,
  nameSuccess,
  contactSuccess,
  passwordSuccess,
  failure
}


// final class RegisterInitial extends RegisterState {}

// final class RegisterLoading extends RegisterState {}

// final class RegisterSuccess extends RegisterState {}

// final class RegisterNameSuccess extends RegisterState {}

// final class RegisterContactSuccess extends RegisterState {}

// final class RegisterPasswordSuccess extends RegisterState {}

// final class RegisterFailure extends RegisterState {
//   const RegisterFailure(String errorMessage)
//       : super(errorMessage: errorMessage);
// }
