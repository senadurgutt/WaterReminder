import 'package:get/get.dart';
import 'package:water_reminder/models/record.dart';

class Recordcontroller extends GetxController {
  var records =
      <Record>[
        Record(date: DateTime.now(), amount: 500, note: "efergerf"),
        Record(date: DateTime.now(), amount: 150),
        Record(date: DateTime.now(), amount: 300, note: "bıhjknjrgerf"),
        Record(date: DateTime.now(), amount: 550),
      ].obs;

  /* void addRecord() {
    records.add(Record(date: DateTime.now(), amount: 880, note: "ddddddddddd"));
  }

  void removeRecord(Record record) {
    records.remove(record);  
  }*/
}
