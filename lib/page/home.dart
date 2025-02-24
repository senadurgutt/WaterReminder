import 'package:flutter/material.dart';
import 'package:water_reminder/page/List.dart';
import 'package:water_reminder/page/graph_view.dart';
class Home extends StatefulWidget {

 Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // appBar: AppBar(title: Text("WATER")),
      body: HistoryView(),
      floatingActionButton: FloatingActionButton(
          onPressed: null,
          ),
    );
  }
}