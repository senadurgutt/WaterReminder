import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/utils/colors.dart';
import 'package:water_reminder/views/home.dart';
import 'controllers/recordController.dart';

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
      home: Home(),
    );
  }
}
