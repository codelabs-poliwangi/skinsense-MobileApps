import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skinisense/presentation/ui/pages/features/auth/repository/auth_repository.dart';
import 'package:skinisense/domain/model/user_model.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    // on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isLoggedIn = await authRepository.isLoggedIn();
      if (isLoggedIn) {
        final user = await authRepository.me();
        if (user != null) {
          emit(AuthAuthenticated(user));
          return;
        }
      }
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Future<void> _onAuthLoginRequested(
  //   AuthLoginRequested event,
  //   Emitter<AuthState> emit,
  // ) async {
  //   emit(AuthLoading());
  //   try {
  //     final user = await authRepository.login(
  //       email: event.email,
  //       password: event.password,
  //     );
      
  //     await authRepository.saveUserCredentials();
      
  //     emit(AuthAuthenticated(user));
  //   } catch (e) {
  //     emit(AuthFailure(e.toString()));
  //   }
  // }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}

