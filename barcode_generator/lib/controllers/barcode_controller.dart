/*
import 'dart:convert';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:barcode_generator/controllers/barcode_controller.dart';
import 'package:barcode_generator/models/barcode_model.dart';

class BarcodeController extends GetxController {
  static const String BARCODES_KEY = 'barcodes';
  var barcodes = <Barcode>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBarcodes();
  }

  // Load barcodes from SharedPreferences
  Future<void> loadBarcodes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final barcodesJson = prefs.getStringList(BARCODES_KEY) ?? [];

      barcodes.value =
          barcodesJson
              .map((json) => Barcode.fromMap(jsonDecode(json)))
              .toList();
    } catch (e) {
      print('Error loading barcodes: $e');
    }
  }

  // Save barcodes to SharedPreferences
  Future<void> saveBarcodes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final barcodesJson =
          barcodes.map((barcode) => jsonEncode(barcode.toMap())).toList();

      await prefs.setStringList(BARCODES_KEY, barcodesJson);
    } catch (e) {
      print('Error saving barcodes: $e');
    }
  }

  // Add a barcode to the list
  Future<void> addBarcode(String code) async {
    // Check if barcode already exists
    if (barcodes.any((barcode) => barcode.code == code)) {
      Get.snackbar(
        'Uyarı',
        'Bu barkod zaten listeye eklenmiş.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final barcode = Barcode(code: code);
    barcodes.add(barcode);
    await saveBarcodes();
  }

  // Remove a barcode from the list
  Future<void> removeBarcode(Barcode barcode) async {
    barcodes.remove(barcode);
    await saveBarcodes();
  }

  // Clear all barcodes
  Future<void> clearBarcodes() async {
    barcodes.clear();
    await saveBarcodes();
  }
}
*/

import 'package:get/get.dart';

class Barcode {
  String code;

  Barcode(this.code);
}

class BarcodeController extends GetxController {
  var barcodes = <Barcode>[].obs; // GetX ile reaktif liste

  // Barkod ekleme fonksiyonu
  void addBarcode(String code) {
    barcodes.add(Barcode(code));
  }

  // Barkod silme fonksiyonu
  void removeBarcode(Barcode barcode) {
    barcodes.remove(barcode);
  }

  // Listeyi temizleme fonksiyonu (opsiyonel)
  void clearBarcodes() {
    barcodes.clear();
  }
}
