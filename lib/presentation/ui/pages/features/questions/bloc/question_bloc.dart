import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/model/question.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/repository/question_repository.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final QuestionRepository _questionRepository;
  List<Question> listQuestion = [];
  int currentIndex = 0;
  List<String?> questionId = [];
  List<String?> answers = [];

  QuestionBloc(this._questionRepository) : super(QuestionInitial()) {
    on<FetchQuestion>((event, emit) async {
      emit(QuestionInitial());
      try {
        emit(QuestionLoading());
        // Get All Questions
        final questions = await _questionRepository.getQuestion();
        listQuestion = questions;

        if (listQuestion.isNotEmpty) {
          answers = List<String?>.filled(listQuestion.length, null);
          questionId = List<String?>.filled(listQuestion.length, null); // ✅ Tambahkan ini
          logger.d("currentIndex: $currentIndex");
          emit(QuestionOnLoaded(listQuestion, currentIndex));
        } else {
          emit(QuestionError("No questions available"));
        }
      } catch (e) {
        emit(QuestionError(e.toString()));
      }
    });

    on<QuestionNext>((event, emit) {
      if (currentIndex < listQuestion.length - 1) {
        currentIndex++;
        logger.d("currentIndex: $currentIndex");
        emit(QuestionOnLoaded(listQuestion, currentIndex));
      }
    });

    on<QuestionPrevious>((event, emit) {
      if (currentIndex > 0) {
        currentIndex--;
        logger.d("currentIndex: $currentIndex");
        emit(QuestionOnLoaded(listQuestion, currentIndex));
      }
    });

    on<QuestionSubmited>((event, emit) {
      if (answers.contains(null)) {
        logger.w("Some questions are unanswered: $answers");
      } else {
        logger.d('all question id is ${questionId}');
        logger.d("All answers are submitted: $answers");
      }
    });

    on<SelectAnswer>((event, emit) {
      // Store the selected answer
      if (answers.length > currentIndex && questionId.length > currentIndex) {
        answers[currentIndex] = event.answer;
        questionId[currentIndex] = event.questionId;
        logger.d("Answer selected for question $questionId is : ${event.answer}");
        emit(QuestionOnLoaded(
            listQuestion, currentIndex)); // Emit the current state
      } else {
        logger.e(
            "Error: Attempting to access index $currentIndex in answers, but list is smaller.");
      }
    });
  }
}
