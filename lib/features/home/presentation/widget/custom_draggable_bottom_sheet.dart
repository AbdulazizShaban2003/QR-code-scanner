import 'package:barcode/core/utiles/app_size.dart';
import 'package:barcode/core/utiles/app_string.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/helper/fun.dart';

class DraggableBottomSheet extends StatelessWidget {
  const DraggableBottomSheet({
    super.key,
    required this.type,
    required this.scannerController,
  });

  final String type;
  final MobileScannerController scannerController;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder:
          (context, controller) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  "Scanned Result:",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Text(
                  "Type: ${type.toUpperCase()}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          type,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        if (type == 'url' || type == 'contact')
                          const SizedBox(height: 24),
                        if (type == 'url')
                          ElevatedButton.icon(
                            onPressed: () {
                              launchURL(type);
                            },
                            icon: const Icon(Icons.open_in_new),
                            label: const Text("Open URL"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                          ),
                        if (type == 'contact')
                          ElevatedButton.icon(
                            onPressed: () {
                              // _saveContact(data);
                            },
                            icon: const Icon(Icons.contact_page),
                            label: const Text("Save Contact"),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(context, 0.016),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Share.share(type);
                        },
                        icon: Icon(Icons.share),
                        label: Text(AppString.share),
                      ),
                    ),
                    verticalSpace(context, 0.016),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          scannerController.start();
                        },
                        icon: Icon(Icons.qr_code_scanner),
                        label: Text(AppString.scanAgain),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }
}
