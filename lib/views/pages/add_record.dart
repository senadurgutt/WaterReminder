import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({super.key});

  @override
  State<AddRecord> createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  int selectedValue = 200;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                ),
                Text("ml", style: TextStyle(fontSize: 30)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
