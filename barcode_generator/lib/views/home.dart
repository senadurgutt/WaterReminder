import 'package:barcode_generator/views/barcode_scanner_page.dart';
import 'package:barcode_generator/views/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/barcode_controller.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _barcodeController = TextEditingController();

  final BarcodeController controller = Get.put(BarcodeController());

  void _openSettings() {
    Get.to(() => SettingsPage());
  }

  void _openBarcodeScanner() {
    Get.to(() => BarcodeScannerPage(textEditingController: _barcodeController));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Barcode Generator",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openSettings,
          ),
        ],
        centerTitle: true,
        backgroundColor: AppColors.disabledColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    maxLength: 20,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(20),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      labelText: "Barkod Değeri",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 10),
                  child: IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    iconSize: 40,
                    onPressed: _openBarcodeScanner,

                    tooltip: 'Barkod Tara',
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (textController.text.isNotEmpty) {
                  controller.addBarcode(textController.text);
                  textController.clear();
                }
              },
              child: Text("Ekle"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.barcodes.length,
                  itemBuilder: (context, index) {
                    String barcodeValue = controller.barcodes[index].code;
                    return Card(
                      child: ListTile(
                        title: Text(
                          barcodeValue,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed:
                              () => controller.removeBarcode(
                                controller.barcodes[index],
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.disabledColor, // Arka plan rengi
        shape: CircularNotchedRectangle(), // Yuvarlatılmış kenarlar
        notchMargin: 8.0,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /*
              Obx(() {
                      final count = _barcodesController.barcodes.length;
                      return Text('Toplam: $count barkod');
                    }),
              */
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white, // Yazı rengini beyaz yap
                ),
                onPressed: () {
                  // Barkod basma işlemi
                },
                child: Text("Tümünü Temizle"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white, // Yazı rengini beyaz yap
                ),
                onPressed: () {
                  // QR kod basma işlemi
                },
                child: Text("Yazdır"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
