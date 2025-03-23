import 'package:barcode/config/routes/app_routes.dart';
import 'package:barcode/config/themes/app_color.dart';
import 'package:barcode/core/utiles/app_size.dart';
import 'package:barcode/features/home/presentation/view/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  double _opacity = 0.0;
  double _iconPosition = -1.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      setState(() {
        _opacity = 1.0;
        _iconPosition = 0.0;
      });

    });
    Future.delayed(const Duration(seconds: 3), () {
      RouteManager.navigateTo(context, const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.pinkColor,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedAlign(
                duration: Duration(milliseconds: 1000),
                curve: Curves.easeOut,
                alignment: Alignment(0, _iconPosition), // يتحرك للأعلى
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 1000),
                  opacity: _opacity,
                  child: Icon(
                    Icons.qr_code_scanner,
                    size: 230,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
              verticalSpace(context, 0.03),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1200),
                opacity: _opacity,
                child: Text(
                  "QR Code",
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteColor,
                  ),
                ),
              ),
              verticalSpace(context, 0.02),
              AnimatedOpacity(
                duration: Duration(milliseconds: 1500),
                opacity: _opacity,
                child: Text(
                  "Scanner and Generation",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.whiteColor,
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
