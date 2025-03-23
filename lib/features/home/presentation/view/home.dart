import 'package:barcode/config/routes/app_routes.dart';
import 'package:barcode/core/utiles/app_string.dart';
import 'package:barcode/features/home/presentation/view/qr_generator_screen.dart';
import 'package:barcode/features/home/presentation/view/qr_scanner_screen.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_color.dart';
import '../../../../core/utiles/app_size.dart';
import '../component/BuildFeatureButton.dart';
import '../widget/custom_app_bar_home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pinkColor,
      body: SafeArea(
        child: Column(
          children: [
            verticalSpace(context, 0.04),
            CustomAppBarHomeScreen(),
            verticalSpace(context, 0.06),
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveWidth(context, 0.1),
                  vertical: responsiveHeight(context, 0.1),
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.blackColor.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    BuildFeatureButton(
                      title: AppString.generateQrCode,
                      icon: Icons.qr_code,
                      onPressed: () {
                        RouteManager.navigateTo(
                          context,
                          const QrGeneratorScreen(),
                        );
                      },
                    ),
                    verticalSpace(context, 0.03),
                    BuildFeatureButton(
                      title: AppString.scanQrCode,
                      icon: Icons.qr_code_scanner,
                      onPressed: () {
                        RouteManager.navigateTo(
                          context,
                          const QrScannerScreen(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
