part of 'question_bloc.dart';

sealed class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

final class FetchQuestion extends QuestionEvent{}

final class QuestionSubmited extends QuestionEvent{}

final class QuestionPrevious extends QuestionEvent {}

final class QuestionNext extends QuestionEvent {}

class SelectAnswer extends QuestionEvent {
  final String answer; // The selected answer

  const SelectAnswer(this.answer);

  @override
  List<Object> get props => [answer];
}