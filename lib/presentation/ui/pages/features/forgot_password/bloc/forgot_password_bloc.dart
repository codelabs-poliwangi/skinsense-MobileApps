import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/provider/forgot_password_provider.dart';
import 'package:skinisense/domain/utils/logger.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordProvider forgotPasswordProvider;

  ForgotPasswordBloc({required this.forgotPasswordProvider}) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailSubmitted>((event, emit) async  {
      try {
        emit(ForgotPasswordLoading()); 
        if(event.email.isEmpty) {
          emit(const ForgotPasswordFailure('Email harus terisi'));
          return;
        }

        await forgotPasswordProvider.forgotPassword(email: event.email);

        emit(ForgotPasswordEmailSuccess(email: event.email));  
      } catch (e) {
        logger.e('Provider Error: $e');
        emit(ForgotPasswordFailure(e.toString()));
      }
    });

    on<ForgotPasswordOtpSubmitted>((event, emit) async {
      emit(ForgotPasswordLoading()); 

      if(event.otp.isEmpty) {
        emit(const ForgotPasswordFailure('Pin harus terisi'));
        return;
      }

      await forgotPasswordProvider.verifyToken(token: event.otp);

      emit(ForgotPasswordOtpSuccess(otp: event.otp));
    });

    on<ForgotPasswordResetSubmitted>((event, emit) async {
      emit(ForgotPasswordLoading()); 

      if(event.token.isEmpty) {
        emit(const ForgotPasswordFailure('Token harus terisi'));
        return;
      }

      if(event.password.isEmpty) {
        emit(const ForgotPasswordFailure('Password harus terisi'));
        return;
      }

      if(event.confirmPassword.isEmpty) {
        emit(const ForgotPasswordFailure('Confirm Password harus terisi'));
        return;
      }

      await forgotPasswordProvider.resetPassword(token: event.token, password: event.password, confirmPassword: event.confirmPassword);

      emit(ForgotPasswordResetSuccess(token: event.token, password: event.password, confirmPassword: event.confirmPassword));
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
