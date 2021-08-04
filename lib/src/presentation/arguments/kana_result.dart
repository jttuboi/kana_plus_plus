import 'package:flutter/widgets.dart';

class KanaResult {
  const KanaResult({
    required this.id,
    required this.imageUrl,
    required this.isCorrect,
    required this.userImage,
  });

  final int id;
  final String imageUrl;
  final bool isCorrect;
  final Image userImage;
}
