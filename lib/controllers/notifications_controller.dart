/*
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
      tzdata.initializeTimeZones();
      tz.setLocalLocation(
        tz.getLocation('Europe/Istanbul'),
      ); 

    initializeNotifications();
  }
  /*
  void showTestNotification() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Bildirimi 🛠',
      'Bu bir test bildirimi!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Kanalı',
          channelDescription: 'Test için bir bildirim kanalı',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }
  */

  void printFormattedTime() {
    DateTime now = DateTime.now().toLocal(); // Yerel saate çevir
    String formattedTime = DateFormat(
      'yyyy-MM-dd HH:mm:ss',
    ).format(now); // Formatla
    print(" Formatlanmış Yerel Saat: $formattedTime");
  }

  void initializeNotifications() async {
    void requestPermissions() async {
      final androidPlugin =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();

      if (androidPlugin != null) {
        await androidPlugin.requestNotificationsPermission();
      }
    }

    requestPermissions();
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload == 'add_record') {
          Get.toNamed('/add_record'); 
      },
    );
  }

  void scheduleDailyNotifications() async {
    await flutterLocalNotificationsPlugin
        .cancelAll(); // Önce tüm bildirimleri iptal et
    _scheduleNotification(21, 35);
    _scheduleNotification(21, 37);
  }

  void _scheduleNotification(int hour, int minute) async {
    final now = DateTime.now().toLocal(); 
    print(" Şu anki yerel zaman: $now");

    var scheduledTime = DateTime(now.year, now.month, now.day, hour, minute);

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    // Bildirim zamanını TZDateTime formatına çevir
    final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);
    print("📢 Bildirim planlanan saat: $tzScheduledTime");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      hour * 100 + minute,
      'Su İçme Hatırlatma 💧',
      'Su içmeyi unutma!',
      tzScheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'water_reminder_channel',
          'Water Reminder',
          channelDescription: 'Günlük su içme hatırlatıcı',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
*/
/*
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    initializeNotifications(); // Bildirimleri başlat
  }

  // Bildirimleri başlatma ve saat dilimini ayarlama
  void initializeNotifications() async {
    // Saat dilimi ayarla veri yüklr
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));

    // Bildirim izni iste
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

     AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // android için bildirim
    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload == 'add_record') {
          Get.toNamed('/add_record'); // Bildirime tıklanınca yönlendirme
        }
      },
    );
  }

  /* 
  void printFormattedTime() {
    DateTime now = DateTime.now().toLocal();
    String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    print("Formatlanmış Yerel Saat: $formattedTime");
  }
  */

  void scheduleDailyNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();

    List<Map<String, int>> times = [
      {'hour': 09, 'minute': 20},
      {'hour': 17, 'minute': 30},
    ];

    for (var time in times) {
      _scheduleNotification(time['hour']!, time['minute']!);
    }
  }

  // Belirtilen saatte bildirim yoksa +1 gün
  void _scheduleNotification(int hour, int minute) async {
    final now = DateTime.now().toLocal();
    DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);
    //   print(" Bildirim planlanan saat: $tzScheduledTime");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      hour * 100 + minute,
      'Water Reminder 💧',
      'Su içmeyi unutma!',
      tzScheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'water_reminder_channel',
          'Water Reminder',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
*/

import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:permission_handler/permission_handler.dart'; // 📌 İzin kontrolü için eklendi

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    initializeNotifications(); // 📌 Bildirimleri başlat
  }

  // 📌 Exact Alarm İznini Kontrol Et ve Gerekirse İste (Android 12+ için)
  Future<void> requestExactAlarmPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.scheduleExactAlarm.isDenied) {
        await Permission.scheduleExactAlarm.request();
      }
    }
  }

  // 📌 Bildirimleri başlatma ve saat dilimini ayarlama
  void initializeNotifications() async {
    await requestExactAlarmPermission(); // 📌 Exact alarm izni iste (Android 12+)

    // 📌 Saat dilimi ayarla
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));

    // 📌 Bildirim izni iste
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload == 'add_record') {
          Get.toNamed('/add_record'); // 📌 Bildirime tıklanınca yönlendirme
        }
      },
    );
  }

  // 📌 Günlük bildirimleri belirli saatlere göre ayarla
  void scheduleDailyNotifications() async {
    await flutterLocalNotificationsPlugin
        .cancelAll(); // 🔄 Önce eski bildirimleri temizle

    List<Map<String, int>> times = [
      {'hour': 09, 'minute': 20},
      {'hour': 17, 'minute': 30},
    ];

    for (var time in times) {
      _scheduleNotification(time['hour']!, time['minute']!);
    }
  }

  // 📌 Belirtilen saatte bildirim yoksa +1 gün
  void _scheduleNotification(int hour, int minute) async {
    final now = DateTime.now().toLocal();
    DateTime scheduledTime = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledTime.isBefore(now)) {
      scheduledTime = scheduledTime.add(const Duration(days: 1));
    }

    final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);
    print("📢 Bildirim planlanan saat: $tzScheduledTime");

    await flutterLocalNotificationsPlugin.zonedSchedule(
      hour * 100 + minute,
      'Water Reminder 💧',
      'Su içmeyi unutma!',
      tzScheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'water_reminder_channel',
          'Water Reminder',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'add_record',
    );
  }
}
