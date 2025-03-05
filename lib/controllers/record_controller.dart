import 'package:get/get.dart';
import 'package:water_reminder/models/record_model.dart';
import 'package:water_reminder/services/database_service.dart';

class Recordcontroller extends GetxController {
  var records =
      [
        RecordModel(
          id: 1,
          amount: 2000,
          date: DateTime.now(),
          note: "Limonlu su",
        ),
      ].obs;
  @override
  void onInit() {
    super.onInit();
    fetchRecords(); //Uygulama açıldığında verileri getiriyo
  }

  Future<void> fetchRecords() async {
    final data = await DatabaseService.readData();
    print("Veritabanından çekilen veri: $data"); // HATA VAR MI KONTROL ET

    records.assignAll(data.map((json) => RecordModel.fromJson(json)).toList());
    records.refresh(); // Güncellenmiş listeyi ekrana getir
  }

  Future<void> addRecord(RecordModel record) async {
    final id = await DatabaseService.createData(
      record.date.toIso8601String(),
      record.amount,
      record.note,
    );
    records.add(
      RecordModel(
        id: id,
        date: record.date,
        amount: record.amount,
        note: record.note,
      ),
    );
  }

  Future<void> deleteRecord(int id) async {
    await DatabaseService.deleteData(id); // Veritabanından silme işlemi
    records.removeWhere((record) => record.id == id); // Listeden de sil
    await fetchRecords(); // Verileri tekrar çek
    records.refresh();
  }

  Future<void> updateRecord(
    int id,
    DateTime date,
    int amount,
    String note,
  ) async {
    await DatabaseService.updateData(id, date.toIso8601String(), amount, note);
    await fetchRecords(); // Güncellenmiş liste
    records.refresh(); // Güncellenmiş listeyi getir
  }

  Map<DateTime, int> calculateDailyTotal() {
    Map<DateTime, int> totalMap = {};

    for (var record in records) {
      DateTime dateOnly = DateTime(
        record.date.year,
        record.date.month,
        record.date.day,
      );

      if (totalMap.containsKey(dateOnly)) {
        totalMap[dateOnly] = totalMap[dateOnly]! + record.amount;
      } else {
        totalMap[dateOnly] = record.amount;
      }
    }
    return totalMap;
  }

  void printLast7DaysRecords() {
    DateTime today = DateTime.now();
    Map<DateTime, int> totalMap = calculateDailyTotal();

    for (int i = 6; i >= 0; i--) {
      DateTime day = DateTime(
        today.year,
        today.month,
        today.day,
      ).subtract(Duration(days: i));
      int amount = totalMap[day] ?? 0;
      print(
        "${day.toIso8601String().substring(0, 10)} tarihindeki toplam su tüketimi: $amount ml",
      );
    }
  }
}
