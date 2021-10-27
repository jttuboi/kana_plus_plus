import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

class PointsData {
  static const _fileUrl = 'assets/points.json';

  Future<Map<String, List<List<Point<double>>>>> preloadData() async {
    final response = await rootBundle.loadString(_fileUrl);
    final jsonFile = json.decode(response) as Map<String, dynamic>;
    return convertToData(jsonFile);
  }

  Map<String, List<List<Point<double>>>> convertToData(Map<String, dynamic> jsonFile) {
    return jsonFile.map((key, value) {
      final strokes = value as List<dynamic>;
      final newStrokes = <List<Point<double>>>[];
      for (final stroke in strokes) {
        final points = stroke as List<dynamic>;
        final newPoints = <Point<double>>[];
        for (final point in points) {
          newPoints.add(Point<double>(point['x'] as double, point['y'] as double));
        }
        newStrokes.add(newPoints);
      }
      return MapEntry(key, newStrokes);
    });
  }
}
