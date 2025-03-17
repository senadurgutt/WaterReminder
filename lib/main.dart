import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:water_reminder/controllers/notifications_controller.dart';
import 'package:water_reminder/utils/colors.dart';
import 'package:water_reminder/views/pages/add_record.dart';
import 'package:water_reminder/views/pages/login_page.dart';
import 'controllers/record_controller.dart';
import 'controllers/user_controller.dart';

void main() {
  Get.put(UserController());
  WidgetsFlutterBinding.ensureInitialized(); // 📌 Flutter bindingleri başlat
  tz.initializeTimeZones(); // 📌 Zaman dilimi desteğini başlat

  final NotificationController notificationController = Get.put(
    NotificationController(),
  ); // 📌 Bildirim denetleyicisini başlat
  notificationController.initializeNotifications();

  notificationController
      .scheduleDailyNotifications(); // 📌 Günlük bildirimleri planla

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
      initialRoute: '/', // 📌 Başlangıç sayfası LoginPage
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(
          name: '/add_record',
          page: () => AddRecord(),
        ), // 📌 Bildirim yönlendirmesi buraya yapılacak
      ],
    );
  }
}
