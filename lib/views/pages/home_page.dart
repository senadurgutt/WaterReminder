import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/controllers/notifications_controller.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/services/database_service.dart';
import 'package:water_reminder/views/pages/add_record.dart';
import 'package:water_reminder/views/pages/graph_page.dart';
import 'package:water_reminder/utils/colors.dart';
import 'package:water_reminder/views/pages/History_page.dart';

class Home extends StatefulWidget {
  Home({super.key});
  final NotificationController _notificationController = Get.put(
    NotificationController(),
  );

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> records = [];
  bool isLoading = true;
  void refreshData() async {
    final data = await DatabaseService.getAllData();
    setState(() {
      records = data;
      isLoading = false;
    });
  }

  int _currentTab = 0;
  Widget selectedpages = HistoryView();
  final Recordcontroller recordcontroller = Get.put(Recordcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectedpages,

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddRecord());
        },
        backgroundColor: AppColors.backgroundColor,

        shape: StadiumBorder(),
        child: Icon(Icons.add), //köşelere yuvarlaklık verir
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // color: AppColors.accentColor,
      bottomNavigationBar: SizedBox(
        height:
            MediaQuery.of(context).size.height * 0.10, // Sayfanın %15 kaplar
        child: AnimatedBottomNavigationBar(
          activeColor: AppColors.activeColor,
          inactiveColor: AppColors.inactiveColor,
          gapLocation: GapLocation.center,
          backgroundColor: AppColors.backgroundColor,

          icons: [Icons.show_chart, Icons.history],
          iconSize: 30,
          activeIndex: _currentTab,
          onTap: (int) {
            setState(() {
              _currentTab = int;
              selectedpages = (int == 0) ? GraphPage() : HistoryView();
            });

            print(int);
          },
        ),
      ),
    );
  }
}
