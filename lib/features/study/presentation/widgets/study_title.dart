import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class StudyTitle extends StatelessWidget {
  const StudyTitle({required String title, Key? key})
      : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(_title, style: TextStyle(fontSize: Device.get().isTablet ? 28.0 : 18.0, fontWeight: FontWeight.bold)),
    );
  }
}
