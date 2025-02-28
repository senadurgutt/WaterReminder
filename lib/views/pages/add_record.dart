import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/models/record_model.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({super.key});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  int selectedValue = 200;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Record"), centerTitle: true),
      body: Column(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FaIcon(FontAwesomeIcons.glassWater, size: 50),
                  NumberPicker(
                    value: selectedValue,
                    minValue: 50,
                    maxValue: 500,
                    step: 50,
                    haptics: true,
                    onChanged:
                        (value) => setState(() {
                          selectedValue = value;
                        }),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  Text("ml", style: TextStyle(fontSize: 30)),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              var newDate = (await showDatePicker(
                context: context,
                initialDate: DateTime.now(), // bugünü göster
                firstDate: DateTime.now().subtract(
                  Duration(days: 2),
                ), // en geç düne su eklenebilir
                lastDate: DateTime.now(), // bugünden sonraki tarih seçilemez
              ));
              if (newDate != null) {
                // eğer tarih seçilmişse onu tutar
                setState(() {
                  selectedDate = newDate;
                });
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.calendar, size: 50),
                    Expanded(
                      child: Text(
                        DateFormat("EEE,MMM d").format(selectedDate),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ElevatedButton(
              onPressed: () {
                final newRecord = RecordModel(
                  id:
                      DateTime.now()
                          .millisecondsSinceEpoch, // Benzersiz bir ID oluştur
                  amount: selectedValue,
                  date: selectedDate,
                  note: "Manuel kayıt", // Varsayılan bir not ekleyebilirsin
                );

                final recordController =
                    Get.find<Recordcontroller>(); // Controller'ı al
                recordController.addRecord(newRecord); // Yeni kaydı ekle

                print(
                  "Kayıt Eklendi: ${newRecord.amount}ml - ${DateFormat("yyyy-MM-dd").format(newRecord.date)}",
                );

                Navigator.pop(context); // Kayıt sonrası önceki sayfaya dön
              },

              child: Text("Save"),
            ),
          ),
        ],
      ),
    );
  }
}
