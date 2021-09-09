import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kana_plus_plus/src/data/datasources/json_file.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/shared_preferences_cache.storage.dart';
import 'package:kana_plus_plus/src/data/singletons/cache.dart';
import 'package:kana_plus_plus/src/data/singletons/file.dart';
import 'package:kana_plus_plus/src/presentation/app.android.dart';
import 'package:kana_plus_plus/src/presentation/app.ios.dart';

void main() {
  // init services before app start
  init().whenComplete(() {
    Platform.isIOS ? runApp(const IosApp()) : runApp(AndroidApp());
  });
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Cache.init(storage: SharedPreferencesCacheStorage());
  await File.init(storage: JsonFileStorage());
  //await Database.init(storage: SqfliteDatabaseStorage());
}
