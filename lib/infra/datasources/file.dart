import 'package:kwriting/infra/infra.dart';

class File {
  factory File() => _instance;
  File._internal();
  static final File _instance = File._internal();

  static late IStorage storage;

  static Future<void> initialize(IStorage pStorage) async {
    storage = pStorage;
    await storage.initialize();
  }
}
