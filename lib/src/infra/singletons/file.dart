import 'package:kwriting/src/infra/datasources/file.interface.storage.dart';

class File {
  // singleton
  factory File() => _instance;
  File._internal();
  static final File _instance = File._internal();

  static late IFileStorage storage;

  // init cache storage. this init() is recommend to start before runApp().
  static Future<void> init(IFileStorage pStorage) async {
    storage = pStorage;
    await storage.init();
  }
}
