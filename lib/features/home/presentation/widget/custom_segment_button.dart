import 'package:flutter/material.dart';

class CustomSegmentButton extends StatelessWidget {
  const CustomSegmentButton({
    super.key,
    required this.selectedType,
    required this.qrData, this.onSelectionChanged,
  });

  final String selectedType;
  final String qrData;
  final void Function(Set<String>)? onSelectionChanged;
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      onSelectionChanged: onSelectionChanged,
      segments: const [
        ButtonSegment(
          value: 'text',
          label: Text("Text"),
          icon: Icon(Icons.text_fields),
        ),
        ButtonSegment(value: 'url', label: Text("URL"), icon: Icon(Icons.link)),
        ButtonSegment(
          value: 'contact',
          label: Text("Contact"),
          icon: Icon(Icons.contact_page),
        ),
      ],
      selected: {selectedType},
    );
  }
}
