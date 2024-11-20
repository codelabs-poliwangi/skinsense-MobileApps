part of 'skin_condition_bloc.dart';

sealed class SkinConditionEvent extends Equatable {
  const SkinConditionEvent();

  @override
  List<Object> get props => [];
}
class FetchSkinCondition extends SkinConditionEvent {}