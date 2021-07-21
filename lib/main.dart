import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/views/android/android_app.dart';

void main() => runApp(AndroidApp());
// TODO por enquanto utilizar o mesmo view para ambos
//void main() => Platform.isAndroid ? runApp(AndroidApp()) : runApp(IOSApp());
// verificar todos os TODOs antes de fazer deploy para remover testes e ver se 
// não tem algo pendente
