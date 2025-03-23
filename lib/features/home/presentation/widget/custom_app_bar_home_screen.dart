import 'package:barcode/config/themes/app_color.dart';
import 'package:barcode/core/utiles/app_string.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarHomeScreen extends StatelessWidget {
  const CustomAppBarHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
       AppString.titleHomeScreen,
        style: GoogleFonts.poppins(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color:AppColor.whiteColor,
        ),
      ),
    );
  }
}
