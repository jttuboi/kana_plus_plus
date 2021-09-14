import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:kana_plus_plus/src/data/datasources/json.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/shared_preferences.storage.dart';
import 'package:kana_plus_plus/src/data/singletons/database.dart';
import 'package:kana_plus_plus/src/data/singletons/file.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_stats.dart';
import 'package:kana_plus_plus/src/domain/entities/point_stats.dart';
import 'package:kana_plus_plus/src/domain/entities/stroke_stats.dart';
import 'package:kana_plus_plus/src/domain/entities/training_stats.dart';
import 'package:kana_plus_plus/src/domain/entities/word_stats.dart';
import 'package:kana_plus_plus/src/presentation/app.android.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  // init services before app start
  init().whenComplete(() {
    runApp(AndroidApp());
    //Platform.isIOS ? runApp(const IosApp()) : runApp(AndroidApp());
  });
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Database.init(storage: SharedPreferencesStorage());
  await File.init(storage: JsonStorage());
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.registerAdapter(KanaTypeAdapter());
  Hive.registerAdapter(PointStatsAdapter());
  Hive.registerAdapter(StrokeStatsAdapter());
  Hive.registerAdapter(KanaStatsAdapter());
  Hive.registerAdapter(WordStatsAdapter());
  Hive.registerAdapter(TrainingStatsAdapter());
}
