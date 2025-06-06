import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as dio;
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/presentation/ui/pages/features/result/model/get_recomendation_product_response_model.dart';
import 'package:skinisense/presentation/ui/pages/features/result/model/scan_successfull_response_model.dart';

import '../../../../../../domain/services/api_client.dart';
import '../../../../../../domain/utils/logger.dart';
import '../../questions/model/result_question_list.dart';

class ResultProvider {
  final ApiClient apiClient;
  ResultProvider(this.apiClient);
  Future<ScanSuccesfullResponseModel> uploadScan({
    required File imageDepan,
    required File imageKiri,
    required File imageKanan,
    required List<ResultQuestionList> answer,
  }) async {
    try {
      final formData = FormData.fromMap({
        'image_depan': await MultipartFile.fromFile(
          imageDepan.path,
          filename: 'image_depan.jpg',
          contentType: DioMediaType.parse('image/jpeg'),
        ),
        'image_kiri': await MultipartFile.fromFile(
          imageKiri.path,
          filename: 'image_kiri.jpg',
          contentType: DioMediaType.parse('image/jpeg'),
        ),
        'image_kanan': await MultipartFile.fromFile(
          imageKanan.path,
          filename: 'image_kanan.jpg',
          contentType: DioMediaType.parse('image/jpeg'),
        ),
        'answer': jsonEncode(
          answer,
        ), // penting: dikirim dalam bentuk string JSON
      });

      final response = await apiClient.post(
        resultMachineLearingUrl,
        data: formData,
        requireAuth: true,
      );
      if (response.statusCode == 200) {
        logger.i('Data product: $response');

        // Pastikan response.data adalah List<dynamic>
        // Parse response sesuai struktur Products
        // final products = Products.fromJson(response.data);
        final scanResult = ScanSuccesfullResponseModel.fromJson(response.data);

        logger.d('Successfully fetched $scanResult');
        return scanResult;
      } else {
        throw Exception('Failed to load scanResult');
      }
    } catch (e) {
      throw ApiException(message: 'Scan error: $e');
    }
  }

  Future<GetRecomendationProductResponseModel> getRecomendationProduct(String id) async {
    try {
      final response = await apiClient.get(
        '$recomendationMachineLearingUrl/$id',
        requireAuth: true,
      );

      if (response.statusCode == 200) {
        logger.i('Data product: $response');

        // Pastikan response.data adalah List<dynamic>
        // Parse response sesuai struktur Products
        // final products = Products.fromJson(response.data);
        final scanResult = GetRecomendationProductResponseModel.fromJson(
          response.data,
        );

        logger.d('Successfully fetched $scanResult');
        return scanResult;
      } else {
        throw Exception('Failed to load scanResult');
      }
    } catch (e) {
      throw Exception('Failed to load scanResult: $e');
    }
  }
}
