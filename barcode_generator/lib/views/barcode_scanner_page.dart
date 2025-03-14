import 'package:barcode_generator/controllers/qr_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class BarcodeScannerPage extends StatefulWidget {
  const BarcodeScannerPage({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  State<BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<BarcodeScannerPage>
    with SingleTickerProviderStateMixin {
  late QrController qrController;
  late AnimationController animationController;
  late Animation<double> laserAnimation;
  final MobileScannerController scannerController = MobileScannerController();
  var hasCameraPermission = false.obs;

  @override
  void initState() {
    super.initState();

    qrController = Get.put(
      QrController(textEditingController: widget.textEditingController),
    );

    // for laser animation
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true); // repeat the animation

    laserAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);

    _checkCameraPermission();
  }

  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.request();
    hasCameraPermission.value = status.isGranted;

    if (!hasCameraPermission.value) {
      Get.snackbar(
        'İzin Hatası',
        'Kamera izni verilmedi. Barkod taraması yapılamaz.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    qrController.dispose();
    scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double cutOutSize = 300; // QR tarayıcı kesim alanı boyutu

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Flaş butonu
          Obx(
            () =>
                hasCameraPermission.value
                    ? IconButton(
                      icon: ValueListenableBuilder(
                        valueListenable: scannerController.torchState,
                        builder: (context, state, child) {
                          return Icon(
                            state == TorchState.on
                                ? Icons.flash_on
                                : Icons.flash_off,
                            color: Colors.white,
                          );
                        },
                      ),
                      onPressed: () => scannerController.toggleTorch(),
                    )
                    : const SizedBox(),
          ),
        ],
      ),
      body: Obx(
        () =>
            hasCameraPermission.value
                ? Stack(
                  children: [
                    // QR scanner
                    MobileScanner(
                      controller: scannerController,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        if (barcodes.isNotEmpty) {
                          final String? code = barcodes.first.rawValue;
                          if (code != null) {
                            widget.textEditingController.text = code;
                            Get.back(); // close the QR scanner page
                          }
                        }
                      },
                    ),

                    // Overlay with cutout
                    Container(
                      color: Colors.black54,
                      child: Center(
                        child: Container(
                          width: cutOutSize,
                          height: cutOutSize,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              // Lazer animasyonu
                              AnimatedBuilder(
                                animation: laserAnimation,
                                builder: (context, child) {
                                  return Positioned(
                                    top: laserAnimation.value * cutOutSize,
                                    left: 0,
                                    right: 0,
                                    child: child!,
                                  );
                                },
                                child: Container(
                                  height: 4, // Lazer çizgisinin yüksekliği
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Bilgilendirici metin
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'QR kod ya da barkodu tarayıcıya hizalayın',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )
                : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Kamera izni verilmedi.',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await _checkCameraPermission();
                          if (!hasCameraPermission.value) {
                            await openAppSettings();
                          }
                        },
                        child: const Text('İzin Ver'),
                      ),
                    ],
                  ),
                ),
      ),
    );
  }
}
