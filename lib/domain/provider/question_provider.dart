import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/question.dart';
import 'package:http/http.dart' as http;

class QuestionProvider {
  Future<Question> getQuestion() async {
    try {
      final response = await http.get(Uri.parse(questionUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        return Question.fromJson(jsonData);
      } else {
        // Handle error if response status code is not 200
        Logger()
            .d("Failed to load questions, status code: ${response.statusCode}");
        // print("Failed to load questions, status code: ${response.statusCode}");
          throw Exception('Failed to load products ${response.statusCode}');
      }
    } catch (e) {
      // Handle exception
      Logger().d("Failed to load questions, status code: ${e}");
      throw Exception('Failed to load products ${e}');
      // return null;
    }
  }
}
