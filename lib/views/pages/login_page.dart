import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/views/pages/profile_page.dart';
import 'package:water_reminder/services/api_services.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  String? accessToken;

  void login() async {
    String? token = await ApiService.loginUser(
      usernameController.text,
      passwordController.text,
    );

    if (token != null) {
      setState(() {
        accessToken = token;
      });
      print("Giriş başarılı! Token: $accessToken");
    } else {
      print("Giriş başarısız!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: login, child: const Text('Login')),
          ],
        ),
      ),
    );
  }
}
