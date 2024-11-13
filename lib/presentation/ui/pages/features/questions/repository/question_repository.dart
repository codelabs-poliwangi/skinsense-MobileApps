import 'package:skinisense/domain/model/question.dart';
import 'package:skinisense/domain/provider/question_provider.dart';

class QuestionRepository {
  final QuestionProvider _questionProvider;
  QuestionRepository(this._questionProvider);
  Future<Question> getQuestion () async{
    try {
      return await _questionProvider.getQuestion();
    } catch (e) {
      throw Exception('Failed to fetch skin condition: $e');
    }
  }
}