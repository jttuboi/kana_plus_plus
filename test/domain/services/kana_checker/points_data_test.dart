import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/infra/services/kana_checker/points_data.dart';

void main() {
  group('PointsData', () {
    late PointsData pointsData;

    setUpAll(() {
      pointsData = PointsData();
    });

    test('converts json to data', () {
      final jsonMap = <String, dynamic>{
        'ぁ': [
          [
            {'x': 0.11, 'y': 0.12},
            {'x': 0.13, 'y': 0.14},
            {'x': 0.15, 'y': 0.16},
            {'x': 0.17, 'y': 0.18}
          ],
          [
            {'x': 0.21, 'y': 0.22},
            {'x': 0.23, 'y': 0.24},
            {'x': 0.25, 'y': 0.26},
            {'x': 0.27, 'y': 0.28}
          ],
          [
            {'x': 0.31, 'y': 0.32},
            {'x': 0.33, 'y': 0.34},
            {'x': 0.35, 'y': 0.36},
            {'x': 0.37, 'y': 0.38},
            {'x': 0.39, 'y': 0.40}
          ]
        ],
      };
      final data = pointsData.convertToData(jsonMap);

      expect(data.keys.first, 'ぁ');
      expect(data['ぁ']![0], const [Offset(0.11, 0.12), Offset(0.13, 0.14), Offset(0.15, 0.16), Offset(0.17, 0.18)]);
      expect(data['ぁ']![1], const [Offset(0.21, 0.22), Offset(0.23, 0.24), Offset(0.25, 0.26), Offset(0.27, 0.28)]);
      expect(data['ぁ']![2], const [Offset(0.31, 0.32), Offset(0.33, 0.34), Offset(0.35, 0.36), Offset(0.37, 0.38), Offset(0.39, 0.40)]);
    });
  });
}
