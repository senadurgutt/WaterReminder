import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/views/graph_page.dart';
import 'package:water_reminder/utils/colors.dart';
import 'package:water_reminder/views/History_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentTab = 0;
  Widget selectedpages = GraphView();
  final Recordcontroller recordcontroller = Get.put(Recordcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("WATER")),
      body: selectedpages,

      floatingActionButton: FloatingActionButton(
        onPressed: recordcontroller.addRecord,
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
              selectedpages = (int == 0) ? GraphView() : HistoryView();
            });

            print(int);
          },
        ),
      ),
    );
  }
}
