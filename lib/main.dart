import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/utils/colors.dart';
import 'package:water_reminder/views/pages/login_page.dart';
import 'controllers/record_controller.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  final controller = Get.put(Recordcontroller());

  MyApp({super.key});
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Water Reminder',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: AppColors.backgroundColor),
      ),
      home: LoginPage(),
    );
  }
}
