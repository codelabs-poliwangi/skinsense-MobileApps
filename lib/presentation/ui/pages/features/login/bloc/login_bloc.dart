import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// Import Repository
import 'package:skinisense/presentation/ui/pages/features/auth/repository/auth_repository.dart';

// Import Model
import 'package:skinisense/domain/model/user.dart' as User;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginWithGoogleEvent>(
        _onLoginWithGoogle); // Register the handler for Google login
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      final user = await authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(LoginSuccess(user));
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  Future<void> _onLoginWithGoogle(
    LoginWithGoogleEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginWithGoogleLoading());

    try {
      final firebaseUser = await authRepository.loginWithGoogle();
      if (firebaseUser != null) {
        // You may want to map firebaseUser  to your User model
        emit(LoginWithGoogleSuccess(firebaseUser));
      } else {
        emit(LoginWithGoogleError());
      }
    } catch (error) {
      emit(LoginWithGoogleError(error.toString()));
    }
  }
}
