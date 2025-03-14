import 'package:flutter_blue_plus/flutter_blue_plus.dart'; //bluethooth cihazlarını taramak /bağlanmak için
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  var isScanning = false.obs; //Tarama işlemi devam ediyor mu?
  var isConnecting = false.obs; //Bağlanma işlemi devam ediyor mu?
  var scanResults = <ScanResult>[].obs; //Bulunan Bluetooth cihazları listesi
  var bluetoothState =
      BluetoothAdapterState.unknown.obs; //Bluetooth'un mevcut durumu

  @override
  void onInit() {
    super.onInit();
    FlutterBluePlus.adapterState.listen((state) {
      bluetoothState.value = state;
    });
  }

  /// Bluetooth taramayı başlat
  Future<void> scanDevice() async {
    scanResults.clear();
    isScanning.value = true;

    FlutterBluePlus.scanResults.listen((results) {
      scanResults.value = results;
    });

    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
    isScanning.value = false;
  }

  /// Bluetooth açma işlemi
  Future<void> turnOnBluetooth() async {
    await FlutterBluePlus.turnOn();
  }
}
