import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/provider/question_provider.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/repository/question_repository.dart';

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
