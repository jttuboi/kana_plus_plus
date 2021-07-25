import 'dart:io';

import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/data/datasources/shared_preferences_storage.provider.dart';
import 'package:kana_plus_plus/src/data/datasources/cache_storage.dart';
import 'package:kana_plus_plus/src/presentation/android_app.dart';
import 'package:kana_plus_plus/src/presentation/ios_app.dart';

void main() {
  // init cache storage before app
  initCacheStorage().then((value) {
    Platform.isIOS ? runApp(const IosApp()) : runApp(AndroidApp());
  });
}

Future<void> initCacheStorage() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheStorage.init(provider: SharedPreferencesStorageProvider());
}
