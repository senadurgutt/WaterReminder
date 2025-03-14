import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:water_reminder/models/user_model.dart';

class ApiService {
  final String baseUrl = "https://dummyjson.com";

  Future<UserModel?> login(String username, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        print("Giriş başarısız: ${response.body}");
        return null;
      }
    } catch (e) {
      print("Hata oluştu: $e");
      return null;
    }
  }
}
