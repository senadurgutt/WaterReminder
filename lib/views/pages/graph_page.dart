import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/views/widgets/graph_widget.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<GraphPage> {
  final Recordcontroller recordcontroller = Get.put(
    Recordcontroller(),
  ); //Getx controller sınıfını kullanabilmek için

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Graph",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: GraphView(),
    );
  }
}
