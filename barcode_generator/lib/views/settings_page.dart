import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import '../controllers/bluetooth_controller.dart';

class SettingsPage extends StatelessWidget {
  final BluetoothController controller = Get.put(BluetoothController());

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return controller.bluetoothState.value == BluetoothAdapterState.off
            ? _buildBluetoothOffUI()
            : _buildBluetoothOnUI();
      }),
    );
  }

  /// Bluetooth Kapalı UI
  Widget _buildBluetoothOffUI() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.bluetooth_disabled, size: 200.0, color: Colors.blue),
          const Text(
            'Bluetooth Kapalı',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (Platform.isAndroid)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: controller.turnOnBluetooth,
                child: const Text('Bluetooth Aç'),
              ),
            ),
        ],
      ),
    );
  }

  /// Bluetooth Açık UI
  Widget _buildBluetoothOnUI() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.scanDevice,
          child: Obx(
            () => Text(
              controller.isScanning.value ? 'Taranıyor...' : 'Cihazları Tara',
            ),
          ),
        ),
        Expanded(child: Obx(() => _buildDeviceList())),
      ],
    );
  }

  /// Cihaz Listesi
  Widget _buildDeviceList() {
    if (controller.scanResults.isEmpty) {
      return const Center(child: Text("Cihaz Bulunamadı"));
    }

    return ListView.builder(
      itemCount: controller.scanResults.length,
      itemBuilder: (context, index) {
        final device = controller.scanResults[index].device;
        return ListTile(
          leading: const Icon(Icons.devices),
          title: Text(
            device.platformName.isEmpty
                ? 'Bilinmeyen Cihaz'
                : device.platformName,
          ),
          subtitle: Text(
            controller.scanResults[index].rssi.toString() + " dBm",
          ),
        );
      },
    );
  }
}
