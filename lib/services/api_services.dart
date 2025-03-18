/*
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
*/

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:water_reminder/models/user_model.dart';
import 'package:flutter/material.dart';

class ApiService {
  final String baseUrl = "https://dummyjson.com";

  /// **📌 Kullanıcı giriş yapar ama token saklanmaz**
  Future<UserModel?> login(String username, String password) async {
    final url = Uri.parse("$baseUrl/auth/login");

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("✅ Giriş başarılı! Token: ${data["token"]}");

        return UserModel.fromJson(data);
      } else {
        print("❌ Giriş başarısız: ${response.body}");
        return null;
      }
    } catch (e) {
      print("⚠ Hata oluştu: $e");
      return null;
    }
  }

  /// **📌 Yetkilendirilmiş API isteği yap (Token sadece giriş sırasında kullanılır)**
  Future<http.Response> getUserData(String token) async {
    final url = Uri.parse("$baseUrl/auth/me");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer $token", // Token sadece geçici olarak kullanılıyor
      },
    );

    return response;
  }

  /// **📌 Çıkış yap ve giriş ekranına yönlendir**
  void logout(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      '/login',
    ); // Kullanıcıyı giriş ekranına yönlendir
    print("🚪 Kullanıcı çıkış yaptı, giriş ekranına yönlendirildi!");
  }
}
