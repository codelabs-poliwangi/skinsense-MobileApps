import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailSubmitted>((event, emit) {
      emit(ForgotPasswordLoading()); 

      if(event.email.isEmpty) {
        emit(const ForgotPasswordFailure('Email harus terisi'));
        return;
      }

      emit(ForgotPasswordEmailSuccess(email: event.email));
    });
  }
}
