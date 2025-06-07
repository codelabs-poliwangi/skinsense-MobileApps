import 'dart:convert';
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/routine.dart';
import 'package:skinisense/domain/services/api_client.dart';

class RoutineProvider {
  final ApiClient apiClient;

  RoutineProvider(this.apiClient);
  Future<List<Routine>> getRoutine() async {
    try {
      final dynamic response = await apiClient.get(
        routineUrl,
        requireAuth: true,
      );

      if (response.statusCode == 200) {
        final List<Routine> routineList = (response.data as List<dynamic>)
              .map((json) => Routine.fromJson(json as Map<String, dynamic>))
              .toList();
        // final List<Routine> routineList = data.map((json) => Routine.fromJson(json)).toList();

        return routineList;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
