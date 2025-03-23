import 'package:barcode/config/themes/app_color.dart';
import 'package:barcode/core/utiles/app_string.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart' show MobileScanner, MobileScannerController;

import '../../../../core/helper/fun.dart';

class CustomBodyScanner extends StatelessWidget {
  const CustomBodyScanner({
    super.key,
    required this.scannerController,
  });

  final MobileScannerController scannerController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(
          controller: scannerController,
          onDetect: (capture) {
            final barcode = capture.barcodes.first;
            if (barcode.rawValue != null) {
              final String code = barcode.rawValue!;
              processScannedData(code, context, scannerController);
            }
          },
        ),
        Positioned(
          bottom: 24,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              AppString.titleBottomScannerScreen,
              style: TextStyle(
                color: AppColor.whiteColor,
                backgroundColor: Colors.black.withOpacity(0.6),
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
