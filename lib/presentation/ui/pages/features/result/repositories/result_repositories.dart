import 'dart:io';

import 'package:skinisense/presentation/ui/pages/features/result/model/get_recomendation_product_response_model.dart';
import 'package:skinisense/presentation/ui/pages/features/result/model/scan_successfull_response_model.dart';
import 'package:skinisense/presentation/ui/pages/features/result/provider/result_provider.dart';

import '../../../../../../domain/utils/logger.dart';
import '../../questions/model/result_question_list.dart';

class ResultRepositories {
  final ResultProvider _resultProvider;

  ResultRepositories(this._resultProvider);

  Future<ScanSuccesfullResponseModel> postScan({
    required File imageDepan,
    required File imageKiri,
    required File imageKanan,
    required List<ResultQuestionList> answer,
  }) async {
    try {
      final response = await _resultProvider.uploadScan(
        answer: answer,
        imageDepan: imageDepan,
        imageKiri: imageKiri,
        imageKanan: imageKanan,
      );
      logger.d('succes fecthing result from repository $response');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<GetRecomendationProductResponseModel> getRecomendation() async {
    try {
      final response = await _resultProvider.getRecomendationProduct();
      logger.d('succes fecthing result from repository $response');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
