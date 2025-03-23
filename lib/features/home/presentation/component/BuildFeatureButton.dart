import 'package:barcode/config/themes/app_color.dart';
import 'package:barcode/core/utiles/app_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;

class BuildFeatureButton extends StatelessWidget {
  const BuildFeatureButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(15),
        height: responsiveHeight(context, 0.23),
        width: responsiveWidth(context, 0.55),
        decoration: BoxDecoration(
          color: AppColor.indigoColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              size:
                  responsiveHeight(context, 0.015) *
                  responsiveWidth(context, 0.015),
              color: AppColor.whiteColor,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColor.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
