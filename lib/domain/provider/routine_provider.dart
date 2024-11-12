import 'dart:convert';

import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/routine.dart';
import 'package:skinisense/domain/services/api_client.dart';

class RoutineProvider {
  final ApiClient apiClient;
  RoutineProvider(this.apiClient);
  Future<List<Routine>>  getRoutine() async{
    try {
      final response = await apiClient.get(routineUrl);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data);
        return data.map((json) => Routine.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}