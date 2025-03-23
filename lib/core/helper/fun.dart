import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart' as contacts;
import 'package:flutter_contacts/properties/email.dart' as contacts;
import 'package:flutter_contacts/properties/phone.dart' as contacts;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../features/home/presentation/widget/custom_draggable_bottom_sheet.dart';


final Map<String, TextEditingController> controllers = {
  'name': TextEditingController(),
  'phone': TextEditingController(),
  'email': TextEditingController(),
  'url': TextEditingController(),
};


String generateQrData(
  String selectedType,
  Map<String, TextEditingController> _controllers,
  TextEditingController _textController,
) {
  switch (selectedType) {
    case 'contact':
      return '''BEGIN:VCARD
VERSION:3.0
FN:${_controllers['name']?.text}
TEL:${_controllers['phone']?.text}
EMAIL:${_controllers['email']?.text}
END:VCARD''';
    case 'url':
      String url = _controllers['url']?.text ?? '';
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }
      return url;
    default:
      return _textController.text;
  }
}
Future<void> shareQRCode(ScreenshotController screenshotController) async {
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = '${directory.path}/qr_code.png';
  final capture = await screenshotController.capture();
  if (capture == null) return;

  File imageFile = File(imagePath);
  await imageFile.writeAsBytes(capture);
  await Share.shareXFiles([XFile(imagePath)], text: "Share QR Code");
}

Future<void> launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  }
}


Future<void> saveContact(String vcardData ,BuildContext context) async {
  final lines = vcardData.split('\n');
  String? name, phone, email;

  for (var line in lines) {
    line = line.trim();

    if (line.startsWith('FN:')) {
      name = line.substring(3).trim();
    } else if (line.startsWith('TEL:') || line.contains('TEL;')) {
      phone = line.split(':').last.trim();
    } else if (line.startsWith('EMAIL:') || line.contains('EMAIL;')) {
      email = line.split(':').last.trim();
    }
  }

  final contact =
  contacts.Contact()
    ..name.first = name ?? ''
    ..phones = [contacts.Phone(phone ?? '')]
    ..emails = [contacts.Email(email ?? '')];
  try {
    await contact.insert();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Contact Saved!")));
  } catch (e) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Failed to save contact!")),
    );
  }
}

Future<void> processScannedData(String? data, BuildContext context, MobileScannerController scannerController) async {
  if (data == null) return;
  scannerController.stop();
  String type = 'text';
  if (data.startsWith('BEGIN:VCARD')) {
    type = 'contact';
  } else if (data.startsWith('htt://') || data.startsWith('https://')) {
    type = 'url';
  }
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => DraggableBottomSheet(type: type, scannerController: scannerController,),
  );

}




