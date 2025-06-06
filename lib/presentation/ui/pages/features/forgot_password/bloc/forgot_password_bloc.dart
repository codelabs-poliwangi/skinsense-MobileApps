import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/provider/forgot_password_provider.dart';
import 'package:skinisense/domain/utils/logger.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordProvider forgotPasswordProvider;

  ForgotPasswordBloc({required this.forgotPasswordProvider})
      : super(const ForgotPasswordState()) {
    on<ForgotPasswordEmailSubmitted>((event, emit) async {
      try {
        emit(state.copyWith(status: ForgotPasswordStatus.loading));

        if (event.email.isEmpty) {
          emit(state.copyWith(
            status: ForgotPasswordStatus.failure,
            error: 'Email harus terisi',
          ));
          return;
        }

        await forgotPasswordProvider.forgotPassword(email: event.email);

        emit(state.copyWith(
          status: ForgotPasswordStatus.emailSuccess,
          email: event.email,
        ));
      } catch (e) {
        logger.e('Failed: $e');
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: 'Failed: ${e ?? 'Something Wrong'}',
        ));
      }
    });

    on<ForgotPasswordOtpSubmitted>((event, emit) async {
      try {
        if (event.otp.isEmpty) {
          emit(state.copyWith(
            status: ForgotPasswordStatus.failure,
            error: 'Pin harus terisi',
          ));
          return;
        }

        await forgotPasswordProvider.verifyToken(token: event.otp);
        emit(state.copyWith(
          status: ForgotPasswordStatus.otpSuccess,
          otp: event.otp,
        ));
      } catch (e) {
        logger.e('Failed: $e');
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: 'Failed: ${e ?? 'Something Wrong'}',
        ));
      }
    });

    on<ForgotPasswordResetSubmitted>((event, emit) async {
      emit(state.copyWith(status: ForgotPasswordStatus.loading));

      if (event.token.isEmpty) {
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: 'Token harus terisi',
        ));
        return;
      }

      if (event.password.isEmpty) {
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: 'Password harus terisi',
        ));
        return;
      }

      if (event.confirmPassword.isEmpty) {
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: 'Confirm Password harus terisi',
        ));
        return;
      }

      try {
        await forgotPasswordProvider.resetPassword(
          token: event.token,
          password: event.password,
          confirmPassword: event.confirmPassword,
        );

        emit(state.copyWith(
          status: ForgotPasswordStatus.resetSuccess,
          token: event.token,
          password: event.password,
          confirmPassword: event.confirmPassword,
        ));
      } catch (e) {
        logger.e('Failed: $e');
        emit(state.copyWith(
          status: ForgotPasswordStatus.failure,
          error: 'Failed: ${e ?? 'Something Wrong'}',
        ));
      }
    });
  }

  @override
  void onChange(Change<ForgotPasswordState> change) {
    super.onChange(change);
    logger.i('State changed from ${change.currentState} to ${change.nextState}');
  }

  @override
  Future<void> close() {
    logger.i("Bloc is being closed");
    return super.close();
  }
}
