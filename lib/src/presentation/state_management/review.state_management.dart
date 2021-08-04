import 'package:flutter/foundation.dart';
import 'package:kana_plus_plus/src/domain/usecases/review.controller.dart';

class ReviewStateManagement extends ChangeNotifier {
  ReviewStateManagement(this._controller);

  final ReviewController _controller;

  String get squareImageUrl => _controller.squareImageUrl;

  String get correctImageUrl => _controller.correctImageUrl;

  String get wrongImageUrl => _controller.wrongImageUrl;
}
