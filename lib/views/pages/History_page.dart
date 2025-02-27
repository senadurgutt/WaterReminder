import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/views/widgets/record_list.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
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
      ),
      body: Obx(
        () =>
            recordcontroller.records.isEmpty
                ? Center(
                  child: Text(
                    "No Record",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
                : ListView.builder(
                  itemCount: recordcontroller.records.length,
                  itemBuilder: (context, index) {
                    return RecordList(record: recordcontroller.records[index]);
                  },
                ),
      ),
    );
  }
}
