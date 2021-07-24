import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/repositories/shared_preferences_storage.provider.dart';
import 'package:kana_plus_plus/src/shared/cache_storage.dart';
import 'package:kana_plus_plus/src/views/android/android_app.dart';

void main() {
  // init cache storage before app
  initCacheStorage().then((value) {
    runApp(AndroidApp());
// TODO por enquanto utilizar o mesmo view para ambos
//void main() => Platform.isIOS ? runApp(IOSApp()) : runApp(AndroidApp());
// verificar todos os TODOs antes de fazer deploy para remover testes e ver se
// não tem algo pendente
// deixar o android no else fará qualquer outro que não seja ios ter a aparencia
// do android, por exemplo, web ou windows
  });
}

Future<void> initCacheStorage() async {
  CacheStorage.init(provider: SharedPreferencesStorageProvider());
}
