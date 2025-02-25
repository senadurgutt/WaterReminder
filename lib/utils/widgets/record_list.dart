import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecordList extends StatelessWidget {
  const RecordList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: ListTile(
          leading: Text(
            DateFormat("EEE, MMM d").format(DateTime.now()),
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          title: Center(
            child: Text(
              "200 ml",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Center(
            child: Text(
              "Record",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: null,
                color: Colors.grey,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: null,
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
