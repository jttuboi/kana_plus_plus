// ignore_for_file: one_member_abstracts

import 'package:kwriting/domain/domain.dart';

abstract class IWordToKanaConverter {
  List<KanaModel> convert(String wordId, Map<String, KanaModel> kanasMap);
}
