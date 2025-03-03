import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/models/record_model.dart';

void showEditDialog(BuildContext context, RecordModel record) {
  final Recordcontroller recordcontroller = Get.find<Recordcontroller>();

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
