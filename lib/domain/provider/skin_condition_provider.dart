import 'dart:convert';

import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/skin_condition.dart';
import 'package:http/http.dart' as http;
class SkinConditionProvider {
  Future<SkinCondition> getSkinCondition() async{
    try {
      final response = await http.get(Uri.parse(skinConditionUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return SkinCondition.fromJson(data[0]);
      }else{
        throw Exception('Failed to load skin condition');
      }
    } catch (e) {
       throw Exception('Failed to load skin condition: $e');
    }
  } 
}