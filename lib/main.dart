import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:kwriting/app.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  init().whenComplete(() {
    runApp(const AndroidApp());
  });
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await File.initialize(JsonStorage());
  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..registerAdapter(KanaTypeAdapter())
    ..registerAdapter(WritingHandAdapter())
    ..registerAdapter(PointStatsAdapter())
    ..registerAdapter(StrokeStatsAdapter())
    ..registerAdapter(KanaStatsAdapter())
    ..registerAdapter(WordStatsAdapter())
    ..registerAdapter(TrainingStatsAdapter());
  await MobileAds.instance.initialize();
}
