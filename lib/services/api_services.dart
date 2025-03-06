import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:water_reminder/models/record_model.dart';

Future<RecordModel> apiCall() async {
  final response = await http.get(
    Uri.parse('https://dummyjson.com/auth/login'),
  );
  if (response.statusCode == 200) {
    return RecordModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load record');
  }
}
