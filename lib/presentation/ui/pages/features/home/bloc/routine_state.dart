part of 'routine_bloc.dart';

sealed class RoutineState extends Equatable {
  const RoutineState();
  
  @override
  List<Object> get props => [];
}

final class RoutineInitial extends RoutineState {}

final class RoutineLoading extends RoutineState {}

final class RoutineOnLoaded extends RoutineState{
  final List<Routine> routines;
  const RoutineOnLoaded(this.routines);
}

final class RoutineError extends RoutineState {
  final String Message;
  const RoutineError(this.Message);
}

