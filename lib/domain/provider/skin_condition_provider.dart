import 'dart:convert';

import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/skinCondition.dart';
import 'package:skinisense/domain/services/api_client.dart';
class SkinConditionProvider {
  final ApiClient apiClient;

  SkinConditionProvider(this.apiClient);
  Future<SkinCondition> getSkinCondition() async{
    try {
      final response = await apiClient.get(skinCOnditionUrl);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data);
        return SkinCondition.fromJson(data[0]);
      }else{
        throw Exception('Failed to load skin condition');
      }
    } catch (e) {
       throw Exception('Failed to load skin condition: $e');
    }
  } 
}