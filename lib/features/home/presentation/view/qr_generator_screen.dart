import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}
class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScreenshotController _screenshotController = ScreenshotController();
  String qrData = '';
  String selectedType = 'text';
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'url': TextEditingController(),
  };
  String _generateQrData() {
    switch (selectedType) {
      case 'contact':
        return ''' BEGIN:VCARD
        VERSION:3.0
        FN:${_controllers['name']?.text}
         TEL:${_controllers['phone']?.text}
        EMAIL:${_controllers['email']?.text}
        END:VCARD''';
      case 'Url':
        String Url = _controllers['Url']?.text ?? '';
        if (!Url.startsWith('http://') && !Url.startsWith('https://')) {
          Url = 'https://$Url';
        }
        return Url;
      default:
        return _textController.text;
    }
  }
  Future<void> _shareQRCode() async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/qr_code.png';
    final capture = await _screenshotController.capture();
    if (capture == null) return null;

    File imageFile = File(imagePath);
    await imageFile.writeAsBytes(capture);
    await Share.shareXFiles([XFile(imagePath)], text: "Share QR Code");
  }
  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (_) {
          setState(() {
            qrData = _generateQrData();
          });
        },
      ),
    );
  }
  Widget _buildInputTextField() {
    switch(selectedType){
      case 'contact':
        return Column(
          children: [
            _buildTextField(_controllers['name']!, "Name"),
            _buildTextField(_controllers['phone']!, "Phone"),
            _buildTextField(_controllers['email']!, "Email"),
          ],
        );
      case 'Url':
        return _buildTextField(_controllers['Url']!, "URL");
      default:
        return TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Enter Text",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onChanged: (value) {
            setState(() {
              qrData = value;
            });
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
