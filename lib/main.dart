import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/data/datasources/database.dart';
import 'package:kana_plus_plus/src/data/datasources/sqflite_database.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/shared_preferences_cache.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/cache.dart';
import 'package:kana_plus_plus/src/presentation/app.android.dart';
import 'package:kana_plus_plus/src/presentation/app.ios.dart';

void main() {
  // init cache storage before app
  initCacheStorage().then((value) {
    Platform.isIOS ? runApp(const IosApp()) : runApp(AndroidApp());
  });
}

Future<void> initCacheStorage() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Cache.init(storage: SharedPreferencesCacheStorage());
  await Database.init(storage: SqfliteDatabaseStorage());
}
