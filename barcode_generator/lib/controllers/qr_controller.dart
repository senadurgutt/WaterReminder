import 'package:get/get.dart';
import 'package:flutter/material.dart';

class QrController extends GetxController {
  var qrResult = ''.obs;
  final TextEditingController textEditingController;

  QrController({required this.textEditingController});
}
