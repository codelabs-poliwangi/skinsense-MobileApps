import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/model/routine.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/routine_repository.dart';

part 'routine_event.dart';
part 'routine_state.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  final RoutineRepository _routineRepository;
  RoutineBloc(this._routineRepository) : super(RoutineInitial()) {
    on<FetchRoutine>((event, emit) async {
      emit(RoutineInitial());
      try {
        emit(RoutineLoading());
        final routines  = await _routineRepository.fetchRoutine();
        emit(RoutineOnLoaded(routines));
      } catch (e) {
        emit(RoutineError(e.toString()));
      }
    });

    on<ToggleRoutineComplete>((event, emit) {
  final currentState = state;
  if (currentState is RoutineOnLoaded) {
    final originalList = currentState.routines;

    // Update list secara manual
    final updatedList = List<Routine>.generate(originalList.length, (index) {
      final item = originalList[index];
      if (index == event.index) {
        return Routine(
          id: item.id,
          image: item.image,
          activity: item.activity,
          isComlete: !item.isComlete, // Toggle status
        );
      } else {
        return item;
      }
    });

    emit(RoutineOnLoaded(updatedList));
  }
});

  }
}
