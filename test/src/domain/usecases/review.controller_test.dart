import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/usecases/review.controller.dart';

void main() {
  final controller = ReviewController();
  group('images url', () {
    test('must return square image url', () {
      final result = controller.squareImageUrl;

      expect(result, ImageUrl.square);
    });
    test('must return correct image url', () {
      final result = controller.correctImageUrl;

      expect(result, ImageUrl.correct);
    });
    test('must return wrong image url', () {
      final result = controller.wrongImageUrl;

      expect(result, ImageUrl.wrong);
    });
  });
}
