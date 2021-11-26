import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class StudyText extends StatelessWidget {
  const StudyText({required String text, Key? key})
      : _text = text,
        super(key: key);

  final String _text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
      child: Text(_text, style: TextStyle(fontSize: Device.get().isTablet ? 24.0 : 16.0), textAlign: TextAlign.justify),
    );
  }
}
