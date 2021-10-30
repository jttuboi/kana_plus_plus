import 'package:hive/hive.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class LanguageRepository implements ILanguageRepository {
  late Box _box;

  Future<void> load() async {
    _box = (Hive.isBoxOpen(BoxTag.settings)) ? Hive.box(BoxTag.settings) : await Hive.openBox(BoxTag.settings);
  }

  @override
  Future<String> getLanguage() async {
    await load();
    return _box.get(DatabaseTag.language, defaultValue: Default.locale);
  }

  @override
  Future<void> updateLanguage(String localeCode) async {
    await load();
    await _box.put(DatabaseTag.language, localeCode);
  }
}
