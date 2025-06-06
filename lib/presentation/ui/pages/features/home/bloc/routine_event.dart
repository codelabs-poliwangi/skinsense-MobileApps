part of 'routine_bloc.dart';

sealed class RoutineEvent extends Equatable {
  const RoutineEvent();

  @override
  List<Object> get props => [];
}
class FetchRoutine extends RoutineEvent { }

class ToggleRoutineComplete extends RoutineEvent {
  final int index;

  const ToggleRoutineComplete(this.index);
}