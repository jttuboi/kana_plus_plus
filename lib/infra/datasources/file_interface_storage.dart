import 'package:kwriting/domain/domain.dart';

abstract class IFileStorage {
  Future<void> initialize();

  List<WordModel> getAllWords();
}
