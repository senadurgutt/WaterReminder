import 'package:http/http.dart' as http;
import 'package:water_reminder/models/api_model.dart';
import 'dart:convert';

class ApiService {
  static const String baseUrl =
      "https://dummyjson.com/auth/login"; // Kendi API adresin

  // Kullanıcı giriş yapma fonksiyonu
  static Future<String?> loginUser(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login'); // API endpoint’in
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String accessToken = data['token']; // Token alanını API'ne göre ayarla
        return accessToken;
      } else {
        return null; // Hata durumunda null döndür
      }
    } catch (e) {
      print('Login Hatası: $e');
      return null;
    }
  }
}















/* 
Future<ApiModel> apiCall() async {
  final response = await http.post(
    Uri.parse('https://dummyjson.com/auth/login'),
  );
  if (response.statusCode == 200) {
    return ApiModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load record');
  }
}


*/