import 'package:get/get.dart';
import 'package:water_reminder/models/record_model.dart';
import 'package:water_reminder/services/database_service.dart';

class Recordcontroller extends GetxController {
  var records =
      <RecordModel>[
        RecordModel(id: 1, amount: 200, date: DateTime.now(), note: "Not 1"),
        RecordModel(id: 2, amount: 300, date: DateTime.now(), note: "Not 2"),
      ].obs;
  @override
  void onInit() {
    super.onInit();
    fetchRecords(); // 📌 Sayfa açıldığında verileri çek
  }

  Future<void> fetchRecords() async {
    final data = await DatabaseService.readData();
    records.assignAll(data.map((json) => RecordModel.fromJson(json)).toList());
  }

  Future<void> addRecord(RecordModel record) async {
    await DatabaseService.createData(
      record.date.toIso8601String(), // 📌 DateTime'ı String'e çevir
      record.amount,
      record.note ?? "",
    );
    fetchRecords(); // 📌 Güncellenmiş listeyi al
  }

  void deleteRecord(int id) {
    records.removeWhere((record) => record.id == id);
  }

  Future<void> updateRecord(
    int id,
    DateTime date,
    int amount,
    String note,
  ) async {
    await DatabaseService.updateData(id, date.toIso8601String(), amount, note);
    fetchRecords(); // 📌 Güncellenmiş listeyi getir
  }
}
