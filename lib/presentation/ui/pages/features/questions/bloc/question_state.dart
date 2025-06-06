part of 'question_bloc.dart';

sealed class QuestionState extends Equatable {
  const QuestionState();

  @override
  List<Object> get props => [];
}

final class QuestionInitial extends QuestionState {}

final class QuestionLoading extends QuestionState {}

final class QuestionOnLoaded extends QuestionState {
  final List<Question> listQuestions; // Change to List<Question>
  final int currentIndex; // Track the current question index

  const QuestionOnLoaded(this.listQuestions, this.currentIndex);
}
final class QuestionScanSuccess extends QuestionState{
  final List<ResultQuestionList> resultQuestion;

  const QuestionScanSuccess({required this.resultQuestion});
  
}
final class QuestionError extends QuestionState {
  final String message;

  const QuestionError(this.message);
}
