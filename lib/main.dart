import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:kwriting/app.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/src/infrastructure/datasources/json.storage.dart';
import 'package:kwriting/src/infrastructure/datasources/shared_preferences.storage.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';
import 'package:kwriting/src/infrastructure/singletons/file.dart';
import 'package:kwriting/training/training.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  init().whenComplete(() {
    runApp(AndroidApp());
  });
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Database.init(storage: SharedPreferencesStorage());
  await File.init(storage: JsonStorage());
  Hive
    ..init((await getApplicationDocumentsDirectory()).path)
    ..registerAdapter(KanaTypeAdapter())
    ..registerAdapter(PointStatsAdapter())
    ..registerAdapter(StrokeStatsAdapter())
    ..registerAdapter(KanaStatsAdapter())
    ..registerAdapter(WordStatsAdapter())
    ..registerAdapter(TrainingStatsAdapter());
  await MobileAds.instance.initialize();
}
