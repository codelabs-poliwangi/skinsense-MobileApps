import 'dart:convert';

import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/routine.dart';
import 'package:http/http.dart' as http;

class RoutineProvider {
  Future<List<Routine>> getRoutine() async {
    try {
      final response = await http.get(Uri.parse(routineUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Routine.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
