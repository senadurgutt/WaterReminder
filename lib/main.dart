import 'package:flutter/material.dart';
import 'package:water_reminder/controller.dart';
import 'package:get/get.dart';
import 'package:water_reminder/page/home.dart';
import 'package:water_reminder/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final controller = Get.put(Controller());

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
      home: Home(),
    );
  }
}
