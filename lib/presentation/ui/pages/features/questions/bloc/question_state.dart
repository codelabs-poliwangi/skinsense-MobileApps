part of 'question_bloc.dart';

sealed class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

final class QuestionInitial extends QuestionState {}

final class QuestionLoading extends QuestionState {}

final class QuesitonOnLoaded extends QuestionState {
  final Question question;
  QuesitonOnLoaded(this.question);
}

final class QuestionError extends QuestionState {
  final String message;

  QuestionError(this.message);
}
