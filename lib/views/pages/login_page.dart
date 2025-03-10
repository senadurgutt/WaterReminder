import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/services/api_services.dart';
import 'package:water_reminder/views/pages/profile_page.dart';
import 'package:water_reminder/controllers/user_controller.dart';

final UserController userController = Get.put(UserController());

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ApiService apiService = ApiService();

  void login(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    final response = await apiService.login(username, password);

    if (response != null && response.containsKey('accessToken')) {
      //response içinde accessToken varsa devam et
      userController.setUser(response);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Giriş başarılı")));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => ProfilePage(
                userData: response,
              ), //response ile kullanıcı verilerini aktar
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Giriş başarısız")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login ',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                login(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
