import 'package:barcode/core/utiles/app_size.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotComponent extends StatelessWidget {
  const ScreenshotComponent({
    super.key,
    required this.screenshotController,
    required this.qrData,
  });

  final ScreenshotController screenshotController;

  final String qrData;

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          size: responsiveWidth(context, 0.004)*responsiveHeight(context, 0.004),
          errorCorrectionLevel: QrErrorCorrectLevel.H,
        ),
      ),
    );
  }
}
