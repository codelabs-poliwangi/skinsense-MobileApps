import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skinisense/domain/model/user_model.dart';

class UserRepository {
  final String baseUrl = "http://qsck4sg0wgksw8oso4gsw4os.103.74.5.192.sslip.io/api";

  Future<User> fetchData(String accessToken) async {
    final response = await http.get(
      Uri.parse("$baseUrl/auth/me"),
      headers: {
        'Authorization' : 'Bearer $accessToken' 
      } 
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    }
    else {
      throw Exception('Error to load user data');
    }
  }
}