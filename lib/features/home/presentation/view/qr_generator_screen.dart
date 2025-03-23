import 'package:barcode/config/themes/app_color.dart';
import 'package:barcode/core/helper/fun.dart';
import 'package:barcode/core/utiles/app_size.dart';
import 'package:barcode/core/utiles/app_string.dart';
import 'package:barcode/features/home/presentation/component/build_text_field.dart';
import 'package:barcode/features/home/presentation/component/elevated_icon_share.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screenshot/screenshot.dart';
import '../component/screenshot.dart';
import '../widget/custom_segment_button.dart';

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

  Widget _buildInputTextField() {
    switch (selectedType) {
      case 'contact':
        return Column(
          children: [
            BuildTextField(
              label: "Name",
              controller: controllers['name']!,
              onChanged:
                  (_) => setState(() {
                    qrData = generateQrData(
                      selectedType,
                      controllers,
                      _textController,
                    );
                  }),
            ),
            BuildTextField(
              controller: controllers['phone']!,
              label: "Phone",
              onChanged:
                  (_) => setState(() {
                    qrData = generateQrData(
                      selectedType,
                      controllers,
                      _textController,
                    );
                  }),
            ),
            BuildTextField(
              controller: controllers['email']!,
              label: "Email",
              onChanged:
                  (_) => setState(() {
                    qrData = generateQrData(
                      selectedType,
                      controllers,
                      _textController,
                    );
                  }),
            ),
          ],
        );
      case 'url':
        return BuildTextField(
          onChanged:
              (_) => setState(() {
                qrData = generateQrData(
                  selectedType,
                  controllers,
                  _textController,
                );
              }),
          controller: controllers['url']!,
          label: "URL",
        );
      default:
        return TextField(
          controller: _textController,
          decoration: InputDecoration(
            labelText: "Enter Text",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
    return Scaffold(
      backgroundColor: AppColor.pinkColor,
      appBar: AppBar(
        foregroundColor: AppColor.whiteColor,
        backgroundColor: AppColor.pinkColor,
        elevation: 0,
        title: Text(AppString.generateQrCode, style: GoogleFonts.poppins()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: AppColor.whiteColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSegmentButton(
                        selectedType: selectedType,
                        qrData: qrData,
                        onSelectionChanged: (selection) {
                          setState(() {
                            selectedType = selection.first;
                            qrData = '';
                          });
                        },
                      ),
                      verticalSpace(context, 0.025),
                      _buildInputTextField(),
                      verticalSpace(context, 0.024),
                      if (qrData.isNotEmpty)
                        Column(
                          children: [
                            Card(
                              color: AppColor.whiteColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    ScreenshotComponent(
                                      screenshotController:
                                          _screenshotController,
                                      qrData: qrData,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      horizontalSpace(context, 0.02),
                      ElevatedIconShare(
                        onPressed: () async {
                          await shareQRCode(_screenshotController);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
