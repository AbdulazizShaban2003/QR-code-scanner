import 'package:barcode/config/themes/app_color.dart';
import 'package:barcode/core/utiles/app_string.dart';
import 'package:barcode/features/home/presentation/widget/no_permission.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widget/body_scanner_screen.dart';

class QrScannerScreen extends StatefulWidget {
  const QrScannerScreen({super.key});

  @override
  State<QrScannerScreen> createState() => _QrScannerScreenState();
}

class _QrScannerScreenState extends State<QrScannerScreen> {
  bool hasPermission = false;
  bool isFlashOn = false;
  late MobileScannerController scannerController;

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController();
    _checkPermission();
  }

  @override
  void dispose() {
    scannerController.dispose();
    super.dispose();
  }

  Future<void> _checkPermission() async {
    final status = await Permission.camera.request();
    setState(() {
      hasPermission = status.isGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !hasPermission
        ? NoPermission(onPressed: _checkPermission)
        : Scaffold(
          backgroundColor: AppColor.pinkColor,
          appBar: AppBar(
            title: Text(AppString.scanQrCode),
            backgroundColor: AppColor.pinkColor,
            foregroundColor: AppColor.whiteColor,
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isFlashOn = !isFlashOn;
                    scannerController.toggleTorch();
                  });
                },
                icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off),
              ),
            ],
          ),
          body: CustomBodyScanner(scannerController: scannerController),
        );
  }
}

