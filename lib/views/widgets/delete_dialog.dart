import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDeleteDialog(BuildContext context, VoidCallback onConfirm) {
  Get.defaultDialog(
    title: "Silme Onayı",
    middleText: "Bu kaydı silmek istediğinizden emin misiniz?",
    textConfirm: "Evet",
    textCancel: "İptal",
    confirmTextColor: Colors.white,
    onConfirm: () {
      onConfirm(); // evet butpnu
      Get.back();
    },
    onCancel: () {
      Get.back(); // iptal butonu
    },
    buttonColor: Colors.red,
  );
}
