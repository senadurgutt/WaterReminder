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
        RecordModel(id: 2, amount: 1500, date: DateTime.now(), note: "Sade su"),
      ].obs;
  @override
  void onInit() {
    super.onInit();
    fetchRecords(); //Uygulama açıldığında verileri getiriyo

    Future.delayed(Duration(seconds: 2), () {
      printTotalRecords(); // 📌 Konsolda çıktı almak için
    });
  }

  Future<void> fetchRecords() async {
    final data = await DatabaseService.readData();
    print("Veritabanından çekilen veri: $data"); // HATA VAR MI KONTROL ET

    records.assignAll(data.map((json) => RecordModel.fromJson(json)).toList());
    records.refresh(); // 📌 Güncellenmiş listeyi ekrana getir
  }

  Future<void> addRecord(RecordModel record) async {
    final id = await DatabaseService.createData(
      record.date.toIso8601String(),
      record.amount,
      record.note,
    );
    records.add(
      RecordModel(
        id: id, // Yeni eklenen ID
        date: record.date,
        amount: record.amount,
        note: record.note,
      ),
    );
  }

  Future<void> deleteRecord(int id) async {
    int result = await DatabaseService.deleteData(id);
    records.removeWhere((record) => record.id == id);

    await fetchRecords(); // 📌 Verileri tekrar çekelim
    records.refresh();
  }

  Future<void> updateRecord(
    int id,
    DateTime date,
    int amount,
    String note,
  ) async {
    await DatabaseService.updateData(id, date.toIso8601String(), amount, note);
    await fetchRecords(); // 📌 Güncellenmiş listeyi getir
    records.refresh(); // 📌 Güncellenmiş listeyi getir
  }

  // Günlük toplam su miktarını hesaplayan metod
  Map<DateTime, int> totalRecords() {
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

  void printTotalRecords() {
    var totals = totalRecords();
    totals.forEach((date, totalAmount) {
      print("$date tarihindeki toplam su tüketimi: $totalAmount ml");
    });
  }
}
