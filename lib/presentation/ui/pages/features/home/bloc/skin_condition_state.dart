part of 'skin_condition_bloc.dart';

sealed class SkinConditionState extends Equatable {
  const SkinConditionState();

  @override
  List<Object> get props => [];
}

final class SkinConditionInitial extends SkinConditionState {}

final class SkinConditionLoading extends SkinConditionState {}

final class SkinConditionLoaded extends SkinConditionState {
  final SkinCondition skinCondition;

  const SkinConditionLoaded(this.skinCondition);
}

final class SkinConditionError extends SkinConditionState {
  final String message;

  SkinConditionError(this.message);
}
