import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:water_reminder/controllers/record_controller.dart';
import 'package:water_reminder/views/widgets/graph_widget.dart';
import 'package:water_reminder/views/pages/profile_page.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<GraphPage> createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphPage> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              Get.to(ProfilePage());
            },
          ),
        ],
      ),
      body: GraphView(),
    );
  }
}
