import 'package:flutter/material.dart';
import 'package:water_reminder/models/api_model.dart';
import 'package:water_reminder/services/api_services.dart';
import "package:water_reminder/views/pages/profile_page.dart";

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 2),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('$ApiModel.image'),
          ),
          SizedBox(height: 12),
          Text(
            "$ApiModel.firstName $ApiModel.lastName",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '$ApiModel.email',
            style: TextStyle(
              color: Color.fromARGB(255, 99, 98, 98),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '$ApiModel.gender',
            style: TextStyle(
              color: Color.fromARGB(255, 99, 98, 98),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
