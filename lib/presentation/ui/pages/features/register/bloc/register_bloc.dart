import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/provider/auth_provider.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/repository/auth_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepository authRepository;

  RegisterBloc({required this.authRepository}) : super(const RegisterState()) {
    on<RegisterStarted>((event, emit) {
      emit(const RegisterState());
    });

    on<RegisterNameSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        if (event.name.isEmpty) {
          emit(state.copyWith(
            isLoading: false,
            error: 'Nama harus terisi',
            status: RegisterStatus.failure,
          ));
          return;
        }

        emit(state.copyWith(
          name: event.name,
          isLoading: false,
          status: RegisterStatus.nameSuccess,));

        print(state.name);

      } catch (error) {
        emit(state.copyWith(
          isLoading: false,
          error: error.toString(),
          status: RegisterStatus.failure,
        ));
      }
    });

    on<RegisterContactSubmitted>((event, emit) {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        if (event.email.isEmpty) {
          emit(state.copyWith(
            isLoading: false,
            error: 'Email harus terisi',
            status: RegisterStatus.failure,
          ));
          return;
        }

        if (event.phone.isEmpty) {
          emit(state.copyWith(
            isLoading: false,
            error: 'Phone harus terisi',
            status: RegisterStatus.failure,
          ));
          return;
        }

        emit(state.copyWith(
          email: event.email,
          phone: event.phone,
          isLoading: false,
          status: RegisterStatus.contactSuccess,
        ));

        print('Name: ${state.name}');
        print('Email: ${state.email}');
        print('Phone: ${state.phone}');

      } catch (error) {
        emit(state.copyWith(
          isLoading: false,
          error: error.toString(),
          status: RegisterStatus.failure,
        ));
      }
    });

    
    on<RegisterPasswordSubmitted>((event, emit) async {
      emit(state.copyWith(isLoading: true, error: null));
      try {
        if (event.password.isEmpty) {
          emit(state.copyWith(
            isLoading: false,
            error: 'Password harus terisi',
            status: RegisterStatus.failure,
          ));
          return;
        }

        if (event.confirmPassword.isEmpty) {
          emit(state.copyWith(
            isLoading: false,
            error: 'Confirm Password harus terisi',
            status: RegisterStatus.failure,
          ));
          return;
        }

        emit(state.copyWith(
          password: event.password,
          confirmPassword: event.confirmPassword,
          isLoading: false,
          status: RegisterStatus.passwordSuccess,
        ));

        print('Name: ${state.name}');
        print('Email: ${state.email}');
        print('Phone: ${state.phone}');
        print('Password: ${state.password}');

        // Call Api
        // await authRepository.register(
        //   name: state.name,
        //   email: state.email,
        //   phone: state.phone,
        //   password: state.password,
        //   confirmPassword: state.confirmPassword,
        // );
      } catch (error) {
        emit(state.copyWith(
          isLoading: false,
          error: error.toString(),
          status: RegisterStatus.failure,
        ));
      }
    });
  }
}
