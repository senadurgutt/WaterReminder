import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/models/record_model.dart';
import 'package:water_reminder/utils/colors.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({super.key});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  int selectedValue = 200;
  DateTime selectedDate = DateTime.now();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Record",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
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
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    Text("ml", style: TextStyle(fontSize: 25)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var newDate = (await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 2)),
                  lastDate: DateTime.now(),
                ));
                if (newDate != null) {
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
                          DateFormat("EEE, MMM d").format(selectedDate),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.noteSticky, size: 50),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: noteController,
                        maxLength: 100, // 100 karakter sınırı
                        maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        decoration: InputDecoration(
                          hintText: "        Add a note...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: ElevatedButton(
                onPressed: () {
                  final newRecord = RecordModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    amount: selectedValue,
                    date: selectedDate,
                    note: noteController.text,
                  );

                  final recordController = Get.find<Recordcontroller>();
                  recordController.addRecord(newRecord);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.backgroundColor,
                  foregroundColor: AppColors.textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ), // Köşeleri yuvarlatır
                  ),
                ),
                child: Text("Save", style: TextStyle(fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
