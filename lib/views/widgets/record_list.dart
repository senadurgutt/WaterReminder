import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/views/widgets/delete_dialog.dart';
import 'package:water_reminder/views/widgets/show_dialog.dart';

class RecordList extends StatelessWidget {
  final Recordcontroller recordcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (recordcontroller.records.isEmpty) {
        return Center(child: Text("Kayıt bulunamadı"));
      }
      final sortedRecords = recordcontroller.records.toList(); //date sıralaması
      sortedRecords.sort((a, b) => b.date.compareTo(a.date));

      return ListView.builder(
        itemCount: sortedRecords.length,
        itemBuilder: (context, index) {
          final record = sortedRecords[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: ListTile(
                leading: Text(
                  DateFormat("EEE, MMM d").format(record.date),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                title: Center(
                  child: Text(
                    "${record.amount} ml",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                subtitle: Center(
                  child: Text(
                    record.note ?? "Not Yok",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showEditDialog(context, record);
                      },
                      color: Colors.grey,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDeleteDialog(context, () {
                          recordcontroller.deleteRecord(record.id);
                          recordcontroller.fetchRecords();
                        });
                      },
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
