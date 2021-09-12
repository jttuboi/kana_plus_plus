import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kana_plus_plus/src/data/datasources/json.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/shared_preferences.storage.dart';
import 'package:kana_plus_plus/src/data/singletons/database.dart';
import 'package:kana_plus_plus/src/data/singletons/file.dart';
import 'package:kana_plus_plus/src/presentation/app.android.dart';

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
}
