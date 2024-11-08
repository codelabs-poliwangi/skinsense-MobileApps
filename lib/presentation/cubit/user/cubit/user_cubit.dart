import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skinisense/domain/model/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  // Menyimpan data user ke dalam state
  void setUser(User user) {
    emit(UserLoaded(user));
  }

  // Menghapus data user
  void clearUser() {
    emit(UserInitial());
  }

  // Menampilkan pesan error
  void showError(String message) {
    emit(UserError(message));
  }
}