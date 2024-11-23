import 'package:bloc/bloc.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/repository/auth_repository.dart';
import 'package:skinisense/domain/model/user.dart' as User;
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>(init);
    // on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  //! checking user apakah sudah login dengan mengcek accesToken dan username nya apakah masih ada atau tidak
  Future<void> init(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    // emit(AuthLoading());
    try {
      logger.d('checking user login');
      final isLoggedIn = await authRepository.isLoggedIn();
      logger.d('user is login  $isLoggedIn');
      if (isLoggedIn) {
        final user = await authRepository.me();
        if (user != null) {
          logger.d("User Authenticated");
          emit(AuthAuthenticated(user));
          return;
        }
      }
      emit(AuthUnauthenticated());
      logger.d("User Not Authenticated");
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  //! function untuk logout
  void _onAuthLogoutRequested(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    try {
      await authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthUnauthenticated());
    }
  }
  // checking apakah ada data me dan refresh token di lokal-> return true/false
}
