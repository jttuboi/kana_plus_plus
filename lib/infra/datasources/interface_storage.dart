import 'package:kwriting/domain/domain.dart';

abstract class IStorage {
  Future<void> initialize();

  List<WordModel> getAllWords();
}
