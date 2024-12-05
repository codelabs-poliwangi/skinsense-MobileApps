import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/question.dart';
import 'package:skinisense/domain/services/api_client.dart';

class QuestionProvider {
  final ApiClient apiClient;
  QuestionProvider(this.apiClient);

  Future<List<Question>> getQuestion() async {
    try {
      final response = await apiClient.get(questionUrl, requireAuth: false);
      if (response.statusCode == 200) {
        // logger.d(response.data);

        // Memastikan response data sesuai dengan List<dynamic> atau decode bila perlu
        final List<dynamic> jsonResponse = response.data is String
            ? json.decode(response.data)
            : response.data;
        // logger.d(jsonResponse);
        // Map data JSON ke dalam objek Question
        return jsonResponse
            .map<Question>((json) => Question.fromJson(json))
            .toList();
      } else {
        Logger()
            .e("Failed to load questions, status code: ${response.statusCode}");
        throw Exception('Failed to load questions: ${response.statusCode}');
      }
    } catch (e) {
      Logger().e("Error fetching questions: $e");
      throw Exception('Failed to load questions: $e');
    }
  }
}
