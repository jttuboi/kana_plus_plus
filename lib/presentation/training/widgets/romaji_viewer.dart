import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class RomajiViewer extends StatelessWidget {
  const RomajiViewer(this.romaji, {Key? key}) : super(key: key);

  final String romaji;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        romaji,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: Device.get().isTablet ? 80 : 50,
          fontFamily: 'PT Sans',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
