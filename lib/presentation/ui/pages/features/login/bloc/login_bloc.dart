import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// Import Repository
import 'package:skinisense/domain/repository/auth_repository.dart';

// Import Model
import 'package:skinisense/domain/model/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit
  ) async {
    emit(LoginLoading());

    try {
      final user = await authRepository.login(
        email: event.email,
        password: event.password,
      );

      emit(LoginSuccess(user));
    }
    catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
