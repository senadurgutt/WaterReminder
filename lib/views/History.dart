import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/controllers/recordController.dart';
import 'package:water_reminder/models/record.dart';
import 'package:water_reminder/utils/colors.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final Recordcontroller recordcontroller = Get.put(
    Recordcontroller(),
  ); //Getx controller sınıfını kullanabilmek için

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "History",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body:
          recordcontroller.records.isEmpty
              ? Center(
                child: Text(
                  "No Record",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
              : Obx(
                () => ListView.builder(
                  itemCount: recordcontroller.records.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: ListTile(
                          leading: Text(
                            DateFormat(
                              'dd/MM/yyyy',
                            ).format(recordcontroller.records[index].date),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          title: Center(
                            child: Text(
                              "${recordcontroller.records[index].amount} ml",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: null,
                                color: AppColors.buttonColor,
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: null,
                                color: AppColors.buttonColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
