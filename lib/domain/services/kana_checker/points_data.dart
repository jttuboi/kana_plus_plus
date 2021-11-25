import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kwriting/core/core.dart';

class PointsData {
  Future<Map<String, List<List<Offset>>>> preloadData() async {
    final response = await rootBundle.loadString(FileUrl.points);
    final jsonMap = json.decode(response) as Map<String, dynamic>;
    return convertToData(jsonMap);
  }

  Map<String, List<List<Offset>>> convertToData(Map<String, dynamic> jsonMap) {
    return jsonMap.map((key, value) {
      final strokes = value as List<dynamic>;
      final newStrokes = <List<Offset>>[];
      for (final stroke in strokes) {
        final points = stroke as List<dynamic>;
        final newPoints = <Offset>[];
        for (final point in points) {
          newPoints.add(Offset(point['x'] as double, point['y'] as double));
        }
        newStrokes.add(newPoints);
      }
      return MapEntry(key, newStrokes);
    });
  }
}
