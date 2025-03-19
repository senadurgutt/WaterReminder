import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/controllers/user_controller.dart';
import 'package:water_reminder/views/pages/profile_page.dart';
import 'package:water_reminder/views/widgets/record_list.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final UserController userController = Get.find();
  final Recordcontroller recordcontroller = Get.put(
    Recordcontroller(),
  ); //Getx controller sınıfını kullanabilmek için

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Get.to(ProfilePage(userData: userController.userData.value));
            },
          ),
        ],
      ),
      body: RecordList(),
    );
  }
}
