import 'package:barcode/core/utiles/app_size.dart';
import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.controller,
    required this.label, this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final Function(String _)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: responsiveHeight(context, 0.016)),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onChanged:onChanged!
      ),
    );
  }
}