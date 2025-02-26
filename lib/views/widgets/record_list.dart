import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/models/record.dart' as Models;

class RecordList extends StatelessWidget {
  final Models.Record record;
  RecordList({super.key, required this.record});

  final Recordcontroller recordcontroller =
      Get.find(); // az önce ilk kez çağırdığımız için put yapmıştık şimdi var olan geti bulmak için find

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListTile(
          leading: Text(
            DateFormat("EEE, MMM d").format(DateTime.now()),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          title: Center(
            child: Text(
              "200 ml",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Center(
            child: Text(
              "Record",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: null,
                color: Colors.grey,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  recordcontroller.removeRecord(record);
                },
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
