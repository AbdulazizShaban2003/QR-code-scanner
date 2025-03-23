import 'package:barcode/core/utiles/app_string.dart';
import 'package:flutter/material.dart';


class ElevatedIconShare extends StatelessWidget {
  const ElevatedIconShare({super.key, required this.onPressed});
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.share),
      label: const Text(AppString.shareQrCode),
    );
  }
}
