import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/services/notification.dart';
import 'package:water_reminder/utils/colors.dart';
import 'package:water_reminder/views/pages/login_page.dart';
import 'controllers/record_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
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
