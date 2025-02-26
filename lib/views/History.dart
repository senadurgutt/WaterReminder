import 'package:flutter/material.dart';
import 'package:water_reminder/utils/widgets/record_list.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("History")),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          RecordList(),
          RecordList(),
          RecordList(),
          RecordList(),
          RecordList(),
          RecordList(),
          RecordList(),
          RecordList(),
          RecordList(),
          RecordList(),
        ],
      ),
    );
  }
}
