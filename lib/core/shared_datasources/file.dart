import 'package:kwriting/core/core.dart';

class File {
  factory File() => _instance;
  File._internal();
  static final File _instance = File._internal();

  static late IFileStorage storage;

  static Future<void> initialize(IFileStorage pStorage) async {
    storage = pStorage;
    await storage.initialize();
  }
}
