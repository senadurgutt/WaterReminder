import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/models/record_model.dart';

class RecordList extends StatelessWidget {
  final Recordcontroller recordcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (recordcontroller.records.isEmpty) {
        return Center(child: Text("Kayıt bulunamadı"));
      }
      print(
        "Güncellenen liste: ${recordcontroller.records}",
      ); // Konsolda kayıtları gör

      return ListView.builder(
        itemCount: recordcontroller.records.length,
        itemBuilder: (context, index) {
          final record = recordcontroller.records[index];

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
                        _showEditDialog(context, record);
                      },
                      color: Colors.grey,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        recordcontroller.deleteRecord(record.id);
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

  void _showEditDialog(BuildContext context, RecordModel record) {
    TextEditingController amountController = TextEditingController(
      text: record.amount.toString(),
    );
    TextEditingController noteController = TextEditingController(
      text: record.note ?? "",
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Kaydı Güncelle"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Miktar (ml)"),
              ),
              TextField(
                controller: noteController,
                decoration: InputDecoration(labelText: "Not"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("İptal"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text("Kaydet"),
              onPressed: () {
                recordcontroller.updateRecord(
                  record.id,
                  record.date,
                  int.parse(amountController.text),
                  noteController.text,
                );
                Navigator.pop(context);
                recordcontroller.fetchRecords();
              },
            ),
          ],
        );
      },
    );
  }
}
