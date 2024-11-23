import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/model/routine.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/routine_repository.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineRepository _routineRepository;
  List<Routine> routines = [];
  RoutineBloc(this._routineRepository) : super(RoutineInitial()) {
    on<FetchRoutine>((event, emit) async {
      emit(RoutineInitial());
      try {
        emit(RoutineLoading());
        routines = await _routineRepository.fetchRoutine();
        emit(RoutineOnLoaded(routines));
      } catch (e) {
        emit(RoutineError(e.toString()));
      }
    });

    on<ToggleRoutineComplete>((event, emit) {
      // Create a new list for immutability
      final updatedRoutines = List<Routine>.from(routines);
      updatedRoutines[event.index] = updatedRoutines[event.index].copyWith(
        isComplete: !updatedRoutines[event.index].isComplete,
      );
      emit(RoutineOnLoaded(updatedRoutines)); // Emit updated list
    });
  }
}
