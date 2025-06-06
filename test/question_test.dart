
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/provider/question_provider.dart';
import 'package:skinisense/domain/utils/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  test("fetching question test", () async {
    // logger.d(di<QuestionProvider>());
    QuestionProvider questionProvider = di<QuestionProvider>();
    // QuestionRepository questionRepository = QuestionRepository(questionProvider);
    final result = await questionProvider.getQuestion();
    logger.d(result);
  });
}
