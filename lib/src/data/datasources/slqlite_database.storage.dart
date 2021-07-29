import 'package:kana_plus_plus/src/data/datasources/interfaces/database.storage.interface.dart';
import 'package:kana_plus_plus/src/data/models/kana.model.dart';
import 'package:kana_plus_plus/src/data/models/translate.model.dart';
import 'package:kana_plus_plus/src/data/models/word.model.dart';
import 'package:kana_plus_plus/src/data/utils/consts.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteDatabaseStorage implements IDatabaseStorage {
  static const int databaseVersion = 1;
  late Database _database;

  @override
  Future<void> init() async {
    final String path = join(await getDatabasesPath(), databaseName);

    await openDatabase(
      path,
      version: databaseVersion,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
    ).then((value) {
      _database = value;
    });
  }

  @override
  Future close() async {
    _database.close();
  }

  Future<void> _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
      CREATE TABLE ${TWords.words}(
        ${TWords.wordId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TWords.word} TEXT NOT NULL,
        ${TWords.romaji} TEXT NOT NULL,
        ${TWords.type} INTEGER NOT NULL,
        ${TWords.imageUrl} TEXT NOT NULL
      )
    """);
    await db.execute("""
      CREATE TABLE ${TKanas.kanas}(
        ${TKanas.kanaId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TKanas.kana} TEXT NOT NULL,
        ${TKanas.romaji} TEXT NOT NULL,
        ${TKanas.imageUrl} TEXT NOT NULL,
        ${TKanas.romajiImageUrl} TEXT NOT NULL
      )
    """);
    await db.execute("""
      CREATE TABLE ${TTranslates.translates}(
        ${TTranslates.wordId} INTEGER,
        ${TTranslates.code} TEXT,
        ${TTranslates.translate} TEXT NOT NULL,
        PRIMARY KEY (${TTranslates.wordId}, ${TTranslates.code}),
        FOREIGN KEY (${TTranslates.wordId})
          REFERENCES ${TWords.words} (${TWords.wordId})
            ON DELETE CASCADE
            ON UPDATE CASCADE
      )
    """);
    // await db.execute("""
    //   CREATE TABLE tags(
    //     tag_id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     tag INTEGER NOT NULL
    //   )
    // """);
    await db.execute("""
      CREATE TABLE ${TWordKana.wordKana}(
        ${TWordKana.wordId} INTEGER,
        ${TWordKana.kanaId} INTEGER,
        PRIMARY KEY (${TWordKana.wordId}, ${TWordKana.kanaId}),
        FOREIGN KEY (${TWordKana.wordId})
          REFERENCES ${TWords.words} (${TWords.wordId})
            ON DELETE CASCADE
            ON UPDATE NO ACTION,
        FOREIGN KEY (${TWordKana.kanaId})
          REFERENCES ${TKanas.kanas} (${TKanas.kanaId})
            ON DELETE CASCADE
            ON UPDATE NO ACTION
      )
    """);
    // await db.execute("""
    //   CREATE TABLE word_tag(
    //     word_id INTEGER,
    //     tag_id INTEGER,
    //     PRIMARY KEY (word_id, tag_id),
    //     FOREIGN KEY (word_id)
    //       REFERENCES words (word_id)
    //         ON DELETE CASCADE
    //         ON UPDATE NO ACTION,
    //     FOREIGN KEY (tag_id)
    //       REFERENCES tags (tag_id)
    //         ON DELETE CASCADE
    //         ON UPDATE NO ACTION
    //   )
    // """);

    _insertNewData(db);
  }

  Future<void> _insertNewData(Database db) async {
    for (int i = 0; i < wordsTest.length; i++) {
      await db.insert(TWords.words, wordsTest[i].toMap());
    }
    for (int i = 0; i < translatesTest.length; i++) {
      await db.insert(TTranslates.translates, translatesTest[i].toMap());
    }
    for (int i = 0; i < kanasTest.length; i++) {
      await db.insert(TKanas.kanas, kanasTest[i].toMap());
    }
    await db.insert(
        TWordKana.wordKana, {TWordKana.wordId: 0, TWordKana.kanaId: 23});
    await db
        .insert(TWordKana.wordKana, {TWordKana.wordId: 0, TWordKana.kanaId: 9});
    await db
        .insert(TWordKana.wordKana, {TWordKana.wordId: 1, TWordKana.kanaId: 1});
    await db.insert(
        TWordKana.wordKana, {TWordKana.wordId: 1, TWordKana.kanaId: 22});
    await db.insert(
        TWordKana.wordKana, {TWordKana.wordId: 2, TWordKana.kanaId: 19});
    await db.insert(
        TWordKana.wordKana, {TWordKana.wordId: 2, TWordKana.kanaId: 39});
    await db
        .insert(TWordKana.wordKana, {TWordKana.wordId: 3, TWordKana.kanaId: 2});
    await db.insert(
        TWordKana.wordKana, {TWordKana.wordId: 3, TWordKana.kanaId: 10});
    await db.insert(
        TWordKana.wordKana, {TWordKana.wordId: 3, TWordKana.kanaId: 47});
    await db
        .insert(TWordKana.wordKana, {TWordKana.wordId: 4, TWordKana.kanaId: 2});
    await db.insert(
        TWordKana.wordKana, {TWordKana.wordId: 4, TWordKana.kanaId: 11});
    await db
        .insert(TWordKana.wordKana, {TWordKana.wordId: 5, TWordKana.kanaId: 2});
    await db.insert(
        TWordKana.wordKana, {TWordKana.wordId: 5, TWordKana.kanaId: 30});
  }

  @override
  Future<List<WordModel>> getWords(String languageCode) async {
    final wordsMap = await _database.rawQuery("""
        SELECT w.${TWords.wordId}, w.${TWords.word}, w.${TWords.imageUrl}, t.${TTranslates.code}, t.${TTranslates.translate}
        FROM ${TWords.words} w
        JOIN ${TTranslates.translates} t
        ON (w.${TWords.wordId} = t.${TTranslates.wordId} AND t.${TTranslates.code} = ?)
    """, [languageCode]);

    if (wordsMap.isEmpty) {
      return [];
    }

    return wordsMap.map((wordMap) {
      return WordModel.fromMap(wordMap);
    }).toList();
  }

  Future<WordModel> getWord(int id) async {
    // final maps = await _database.query(
    //   "words",
    //   columns: ["word_id", "word", "romaji", "type", "image_url"],
    //   where: "word_id = ?",
    //   whereArgs: [id],
    // );

    // if (maps.isNotEmpty) {
    //   return WordModel.fromMap(maps.first);
    // }
    return const WordModel.empty();
  }
}

final List<WordModel> wordsTest = [
  const WordModel(
    id: 0,
    word: "ねこ",
    romaji: "neko",
    type: KanaType.onlyHiragana,
    imageUrl: "lib/assets/images/words/cat.png",
  ),
  const WordModel(
    id: 1,
    word: "いぬ",
    romaji: "inu",
    type: KanaType.onlyHiragana,
    imageUrl: "lib/assets/images/words/dog.png",
  ),
  const WordModel(
    id: 2,
    word: "とり",
    romaji: "tori",
    type: KanaType.onlyHiragana,
    imageUrl: "lib/assets/images/words/bird.png",
  ),
  const WordModel(
    id: 3,
    word: "うさぎ",
    romaji: "usagi",
    type: KanaType.onlyHiragana,
    imageUrl: "lib/assets/images/words/rabbit.png",
  ),
  const WordModel(
    id: 4,
    word: "うし",
    romaji: "ushi",
    type: KanaType.onlyHiragana,
    imageUrl: "lib/assets/images/words/cow.png",
  ),
  const WordModel(
    id: 5,
    word: "うま",
    romaji: "uma",
    type: KanaType.onlyHiragana,
    imageUrl: "lib/assets/images/words/horse.png",
  ),
];

final translatesTest = [
  const TranslateModel(id: 0, code: "en", translate: "cat"),
  const TranslateModel(id: 1, code: "en", translate: "dog"),
  const TranslateModel(id: 2, code: "en", translate: "bird"),
  const TranslateModel(id: 3, code: "en", translate: "rabbit"),
  const TranslateModel(id: 4, code: "en", translate: "cow"),
  const TranslateModel(id: 5, code: "en", translate: "horse"),
  const TranslateModel(id: 0, code: "pt_BR", translate: "gato"),
  const TranslateModel(id: 1, code: "pt_BR", translate: "cachorro"),
  const TranslateModel(id: 2, code: "pt_BR", translate: "pássaro"),
  const TranslateModel(id: 3, code: "pt_BR", translate: "coelho"),
  const TranslateModel(id: 4, code: "pt_BR", translate: "vaca"),
  const TranslateModel(id: 5, code: "pt_BR", translate: "cavalo"),
  const TranslateModel(id: 0, code: "es", translate: "gato"),
  const TranslateModel(id: 1, code: "es", translate: "perro"),
  const TranslateModel(id: 2, code: "es", translate: "pájaro"),
  const TranslateModel(id: 3, code: "es", translate: "conejo"),
  const TranslateModel(id: 4, code: "es", translate: "vaca"),
  const TranslateModel(id: 5, code: "es", translate: "caballo"),
];

final kanasTest = [
  const KanaModel(
    id: 0,
    kana: "あ",
    romaji: "a",
    imageUrl: "lib/assets/images/hiragana/a.png",
    romajiImageUrl: "lib/assets/images/romaji/a.png",
  ),
  const KanaModel(
    id: 1,
    kana: "い",
    romaji: "i",
    imageUrl: "lib/assets/images/hiragana/i.png",
    romajiImageUrl: "lib/assets/images/romaji/i.png",
  ),
  const KanaModel(
    id: 2,
    kana: "う",
    romaji: "u",
    imageUrl: "lib/assets/images/hiragana/u.png",
    romajiImageUrl: "lib/assets/images/romaji/u.png",
  ),
  const KanaModel(
    id: 3,
    kana: "え",
    romaji: "e",
    imageUrl: "lib/assets/images/hiragana/e.png",
    romajiImageUrl: "lib/assets/images/romaji/e.png",
  ),
  const KanaModel(
    id: 4,
    kana: "お",
    romaji: "o",
    imageUrl: "lib/assets/images/hiragana/o.png",
    romajiImageUrl: "lib/assets/images/romaji/o.png",
  ),
  const KanaModel(
    id: 5,
    kana: "か",
    romaji: "ka",
    imageUrl: "lib/assets/images/hiragana/ka.png",
    romajiImageUrl: "lib/assets/images/romaji/ka.png",
  ),
  const KanaModel(
    id: 6,
    kana: "き",
    romaji: "ki",
    imageUrl: "lib/assets/images/hiragana/ki.png",
    romajiImageUrl: "lib/assets/images/romaji/ki.png",
  ),
  const KanaModel(
    id: 7,
    kana: "く",
    romaji: "ku",
    imageUrl: "lib/assets/images/hiragana/ku.png",
    romajiImageUrl: "lib/assets/images/romaji/ku.png",
  ),
  const KanaModel(
    id: 8,
    kana: "け",
    romaji: "ke",
    imageUrl: "lib/assets/images/hiragana/ke.png",
    romajiImageUrl: "lib/assets/images/romaji/ke.png",
  ),
  const KanaModel(
    id: 9,
    kana: "こ",
    romaji: "ko",
    imageUrl: "lib/assets/images/hiragana/ko.png",
    romajiImageUrl: "lib/assets/images/romaji/ko.png",
  ),
  const KanaModel(
    id: 10,
    kana: "さ",
    romaji: "sa",
    imageUrl: "lib/assets/images/hiragana/sa.png",
    romajiImageUrl: "lib/assets/images/romaji/sa.png",
  ),
  const KanaModel(
    id: 11,
    kana: "し",
    romaji: "shi",
    imageUrl: "lib/assets/images/hiragana/si.png",
    romajiImageUrl: "lib/assets/images/romaji/si.png",
  ),
  const KanaModel(
    id: 12,
    kana: "す",
    romaji: "su",
    imageUrl: "lib/assets/images/hiragana/su.png",
    romajiImageUrl: "lib/assets/images/romaji/su.png",
  ),
  const KanaModel(
    id: 13,
    kana: "せ",
    romaji: "se",
    imageUrl: "lib/assets/images/hiragana/se.png",
    romajiImageUrl: "lib/assets/images/romaji/se.png",
  ),
  const KanaModel(
    id: 14,
    kana: "そ",
    romaji: "so",
    imageUrl: "lib/assets/images/hiragana/so.png",
    romajiImageUrl: "lib/assets/images/romaji/so.png",
  ),
  const KanaModel(
    id: 15,
    kana: "た",
    romaji: "ta",
    imageUrl: "lib/assets/images/hiragana/ta.png",
    romajiImageUrl: "lib/assets/images/romaji/ta.png",
  ),
  const KanaModel(
    id: 16,
    kana: "ち",
    romaji: "chi",
    imageUrl: "lib/assets/images/hiragana/chi.png",
    romajiImageUrl: "lib/assets/images/romaji/chi.png",
  ),
  const KanaModel(
    id: 17,
    kana: "つ",
    romaji: "tsu",
    imageUrl: "lib/assets/images/hiragana/tsu.png",
    romajiImageUrl: "lib/assets/images/romaji/tsu.png",
  ),
  const KanaModel(
    id: 18,
    kana: "て",
    romaji: "te",
    imageUrl: "lib/assets/images/hiragana/te.png",
    romajiImageUrl: "lib/assets/images/romaji/te.png",
  ),
  const KanaModel(
    id: 19,
    kana: "と",
    romaji: "to",
    imageUrl: "lib/assets/images/hiragana/to.png",
    romajiImageUrl: "lib/assets/images/romaji/to.png",
  ),
  const KanaModel(
    id: 20,
    kana: "な",
    romaji: "na",
    imageUrl: "lib/assets/images/hiragana/na.png",
    romajiImageUrl: "lib/assets/images/romaji/na.png",
  ),
  const KanaModel(
    id: 21,
    kana: "に",
    romaji: "ni",
    imageUrl: "lib/assets/images/hiragana/ni.png",
    romajiImageUrl: "lib/assets/images/romaji/ni.png",
  ),
  const KanaModel(
    id: 22,
    kana: "ぬ",
    romaji: "nu",
    imageUrl: "lib/assets/images/hiragana/nu.png",
    romajiImageUrl: "lib/assets/images/romaji/nu.png",
  ),
  const KanaModel(
    id: 23,
    kana: "ね",
    romaji: "ne",
    imageUrl: "lib/assets/images/hiragana/ne.png",
    romajiImageUrl: "lib/assets/images/romaji/ne.png",
  ),
  const KanaModel(
    id: 24,
    kana: "の",
    romaji: "no",
    imageUrl: "lib/assets/images/hiragana/no.png",
    romajiImageUrl: "lib/assets/images/romaji/no.png",
  ),
  const KanaModel(
    id: 25,
    kana: "は",
    romaji: "ha",
    imageUrl: "lib/assets/images/hiragana/ha.png",
    romajiImageUrl: "lib/assets/images/romaji/ha.png",
  ),
  const KanaModel(
    id: 26,
    kana: "ひ",
    romaji: "hi",
    imageUrl: "lib/assets/images/hiragana/hi.png",
    romajiImageUrl: "lib/assets/images/romaji/hi.png",
  ),
  const KanaModel(
    id: 27,
    kana: "ふ",
    romaji: "fu",
    imageUrl: "lib/assets/images/hiragana/fu.png",
    romajiImageUrl: "lib/assets/images/romaji/fu.png",
  ),
  const KanaModel(
    id: 28,
    kana: "へ",
    romaji: "he",
    imageUrl: "lib/assets/images/hiragana/he.png",
    romajiImageUrl: "lib/assets/images/romaji/he.png",
  ),
  const KanaModel(
    id: 29,
    kana: "ほ",
    romaji: "ho",
    imageUrl: "lib/assets/images/hiragana/ho.png",
    romajiImageUrl: "lib/assets/images/romaji/ho.png",
  ),
  const KanaModel(
    id: 30,
    kana: "ま",
    romaji: "ma",
    imageUrl: "lib/assets/images/hiragana/ma.png",
    romajiImageUrl: "lib/assets/images/romaji/ma.png",
  ),
  const KanaModel(
    id: 31,
    kana: "み",
    romaji: "mi",
    imageUrl: "lib/assets/images/hiragana/mi.png",
    romajiImageUrl: "lib/assets/images/romaji/mi.png",
  ),
  const KanaModel(
    id: 32,
    kana: "む",
    romaji: "mu",
    imageUrl: "lib/assets/images/hiragana/mu.png",
    romajiImageUrl: "lib/assets/images/romaji/mu.png",
  ),
  const KanaModel(
    id: 33,
    kana: "め",
    romaji: "me",
    imageUrl: "lib/assets/images/hiragana/me.png",
    romajiImageUrl: "lib/assets/images/romaji/me.png",
  ),
  const KanaModel(
    id: 34,
    kana: "も",
    romaji: "mo",
    imageUrl: "lib/assets/images/hiragana/mo.png",
    romajiImageUrl: "lib/assets/images/romaji/mo.png",
  ),
  const KanaModel(
    id: 35,
    kana: "や",
    romaji: "ya",
    imageUrl: "lib/assets/images/hiragana/ya.png",
    romajiImageUrl: "lib/assets/images/romaji/ya.png",
  ),
  const KanaModel(
    id: 36,
    kana: "ゆ",
    romaji: "yu",
    imageUrl: "lib/assets/images/hiragana/yu.png",
    romajiImageUrl: "lib/assets/images/romaji/yu.png",
  ),
  const KanaModel(
    id: 37,
    kana: "よ",
    romaji: "yo",
    imageUrl: "lib/assets/images/hiragana/yo.png",
    romajiImageUrl: "lib/assets/images/romaji/yo.png",
  ),
  const KanaModel(
    id: 38,
    kana: "ら",
    romaji: "ra",
    imageUrl: "lib/assets/images/hiragana/ra.png",
    romajiImageUrl: "lib/assets/images/romaji/ra.png",
  ),
  const KanaModel(
    id: 39,
    kana: "り",
    romaji: "ri",
    imageUrl: "lib/assets/images/hiragana/ri.png",
    romajiImageUrl: "lib/assets/images/romaji/ri.png",
  ),
  const KanaModel(
    id: 40,
    kana: "る",
    romaji: "ru",
    imageUrl: "lib/assets/images/hiragana/ru.png",
    romajiImageUrl: "lib/assets/images/romaji/ru.png",
  ),
  const KanaModel(
    id: 41,
    kana: "れ",
    romaji: "re",
    imageUrl: "lib/assets/images/hiragana/re.png",
    romajiImageUrl: "lib/assets/images/romaji/re.png",
  ),
  const KanaModel(
    id: 42,
    kana: "ろ",
    romaji: "ro",
    imageUrl: "lib/assets/images/hiragana/ro.png",
    romajiImageUrl: "lib/assets/images/romaji/ro.png",
  ),
  const KanaModel(
    id: 43,
    kana: "わ",
    romaji: "wa",
    imageUrl: "lib/assets/images/hiragana/wa.png",
    romajiImageUrl: "lib/assets/images/romaji/wa.png",
  ),
  const KanaModel(
    id: 44,
    kana: "を",
    romaji: "wo",
    imageUrl: "lib/assets/images/hiragana/wo.png",
    romajiImageUrl: "lib/assets/images/romaji/wo.png",
  ),
  const KanaModel(
    id: 45,
    kana: "ん",
    romaji: "n",
    imageUrl: "lib/assets/images/hiragana/n.png",
    romajiImageUrl: "lib/assets/images/romaji/n.png",
  ),
  const KanaModel(
    id: 46,
    kana: "が",
    romaji: "ga",
    imageUrl: "lib/assets/images/hiragana/ga.png",
    romajiImageUrl: "lib/assets/images/romaji/ga.png",
  ),
  const KanaModel(
    id: 47,
    kana: "ぎ",
    romaji: "gi",
    imageUrl: "lib/assets/images/hiragana/gi.png",
    romajiImageUrl: "lib/assets/images/romaji/gi.png",
  ),
  const KanaModel(
    id: 48,
    kana: "ぐ",
    romaji: "gu",
    imageUrl: "lib/assets/images/hiragana/gu.png",
    romajiImageUrl: "lib/assets/images/romaji/gu.png",
  ),
  const KanaModel(
    id: 49,
    kana: "げ",
    romaji: "ge",
    imageUrl: "lib/assets/images/hiragana/ge.png",
    romajiImageUrl: "lib/assets/images/romaji/ge.png",
  ),
  const KanaModel(
    id: 50,
    kana: "ご",
    romaji: "go",
    imageUrl: "lib/assets/images/hiragana/go.png",
    romajiImageUrl: "lib/assets/images/romaji/go.png",
  ),
  const KanaModel(
    id: 51,
    kana: "ざ",
    romaji: "za",
    imageUrl: "lib/assets/images/hiragana/za.png",
    romajiImageUrl: "lib/assets/images/romaji/za.png",
  ),
  const KanaModel(
    id: 52,
    kana: "じ",
    romaji: "ji",
    imageUrl: "lib/assets/images/hiragana/ji.png",
    romajiImageUrl: "lib/assets/images/romaji/ji.png",
  ),
  const KanaModel(
    id: 53,
    kana: "ず",
    romaji: "zu",
    imageUrl: "lib/assets/images/hiragana/zu.png",
    romajiImageUrl: "lib/assets/images/romaji/zu.png",
  ),
  const KanaModel(
    id: 54,
    kana: "ぜ",
    romaji: "ze",
    imageUrl: "lib/assets/images/hiragana/ze.png",
    romajiImageUrl: "lib/assets/images/romaji/ze.png",
  ),
  const KanaModel(
    id: 55,
    kana: "ぞ",
    romaji: "zo",
    imageUrl: "lib/assets/images/hiragana/zo.png",
    romajiImageUrl: "lib/assets/images/romaji/zo.png",
  ),
  const KanaModel(
    id: 56,
    kana: "だ",
    romaji: "da",
    imageUrl: "lib/assets/images/hiragana/da.png",
    romajiImageUrl: "lib/assets/images/romaji/da.png",
  ),
  const KanaModel(
    id: 57,
    kana: "ぢ",
    romaji: "ji, dji, jyi",
    imageUrl: "lib/assets/images/hiragana/dji.png",
    romajiImageUrl: "lib/assets/images/romaji/dji.png",
  ),
  const KanaModel(
    id: 58,
    kana: "づ",
    romaji: "dzu, zu",
    imageUrl: "lib/assets/images/hiragana/dzu.png",
    romajiImageUrl: "lib/assets/images/romaji/dzu.png",
  ),
  const KanaModel(
    id: 59,
    kana: "で",
    romaji: "de",
    imageUrl: "lib/assets/images/hiragana/de.png",
    romajiImageUrl: "lib/assets/images/romaji/de.png",
  ),
  const KanaModel(
    id: 60,
    kana: "ど",
    romaji: "do",
    imageUrl: "lib/assets/images/hiragana/do.png",
    romajiImageUrl: "lib/assets/images/romaji/do.png",
  ),
  const KanaModel(
    id: 61,
    kana: "ば",
    romaji: "ba",
    imageUrl: "lib/assets/images/hiragana/ba.png",
    romajiImageUrl: "lib/assets/images/romaji/ba.png",
  ),
  const KanaModel(
    id: 62,
    kana: "び",
    romaji: "bi",
    imageUrl: "lib/assets/images/hiragana/bi.png",
    romajiImageUrl: "lib/assets/images/romaji/bi.png",
  ),
  const KanaModel(
    id: 63,
    kana: "ぶ",
    romaji: "bu",
    imageUrl: "lib/assets/images/hiragana/bu.png",
    romajiImageUrl: "lib/assets/images/romaji/bu.png",
  ),
  const KanaModel(
    id: 64,
    kana: "べ",
    romaji: "be",
    imageUrl: "lib/assets/images/hiragana/be.png",
    romajiImageUrl: "lib/assets/images/romaji/be.png",
  ),
  const KanaModel(
    id: 65,
    kana: "ぼ",
    romaji: "bo",
    imageUrl: "lib/assets/images/hiragana/bo.png",
    romajiImageUrl: "lib/assets/images/romaji/bo.png",
  ),
  const KanaModel(
    id: 66,
    kana: "ぱ",
    romaji: "pa",
    imageUrl: "lib/assets/images/hiragana/pa.png",
    romajiImageUrl: "lib/assets/images/romaji/pa.png",
  ),
  const KanaModel(
    id: 67,
    kana: "ぴ",
    romaji: "pi",
    imageUrl: "lib/assets/images/hiragana/pi.png",
    romajiImageUrl: "lib/assets/images/romaji/pi.png",
  ),
  const KanaModel(
    id: 68,
    kana: "ぷ",
    romaji: "pu",
    imageUrl: "lib/assets/images/hiragana/pu.png",
    romajiImageUrl: "lib/assets/images/romaji/pu.png",
  ),
  const KanaModel(
    id: 69,
    kana: "ぺ",
    romaji: "pe",
    imageUrl: "lib/assets/images/hiragana/pe.png",
    romajiImageUrl: "lib/assets/images/romaji/pe.png",
  ),
  const KanaModel(
    id: 70,
    kana: "ぽ",
    romaji: "po",
    imageUrl: "lib/assets/images/hiragana/po.png",
    romajiImageUrl: "lib/assets/images/romaji/po.png",
  ),
  const KanaModel(
    id: 71,
    kana: "ゃ",
    romaji: "x ya",
    imageUrl: "lib/assets/images/hiragana/x0.png",
    romajiImageUrl: "lib/assets/images/romaji/x0.png",
  ),
  const KanaModel(
    id: 72,
    kana: "ゅ",
    romaji: "x yu",
    imageUrl: "lib/assets/images/hiragana/x1.png",
    romajiImageUrl: "lib/assets/images/romaji/x1.png",
  ),
  const KanaModel(
    id: 73,
    kana: "ょ",
    romaji: "x yo",
    imageUrl: "lib/assets/images/hiragana/x2.png",
    romajiImageUrl: "lib/assets/images/romaji/x2.png",
  ),
  const KanaModel(
    id: 74,
    kana: "っ",
    romaji: "x tsu",
    imageUrl: "lib/assets/images/hiragana/x3.png",
    romajiImageUrl: "lib/assets/images/romaji/x3.png",
  ),
  const KanaModel(
    id: 75,
    kana: "ゝ",
    romaji: "x rep",
    imageUrl: "lib/assets/images/hiragana/x4.png",
    romajiImageUrl: "lib/assets/images/romaji/x4.png",
  ),
  const KanaModel(
    id: 76,
    kana: "ゞ",
    romaji: "x rep2",
    imageUrl: "lib/assets/images/hiragana/x5.png",
    romajiImageUrl: "lib/assets/images/romaji/x5.png",
  ),
  const KanaModel(
    id: 77,
    kana: "ア",
    romaji: "a",
    imageUrl: "lib/assets/images/katakana/a.png",
    romajiImageUrl: "lib/assets/images/romaji/a.png",
  ),
  const KanaModel(
    id: 78,
    kana: "イ",
    romaji: "i",
    imageUrl: "lib/assets/images/katakana/i.png",
    romajiImageUrl: "lib/assets/images/romaji/i.png",
  ),
  const KanaModel(
    id: 79,
    kana: "ウ",
    romaji: "u",
    imageUrl: "lib/assets/images/katakana/u.png",
    romajiImageUrl: "lib/assets/images/romaji/u.png",
  ),
  const KanaModel(
    id: 80,
    kana: "エ",
    romaji: "e",
    imageUrl: "lib/assets/images/katakana/e.png",
    romajiImageUrl: "lib/assets/images/romaji/e.png",
  ),
  const KanaModel(
    id: 81,
    kana: "オ",
    romaji: "o",
    imageUrl: "lib/assets/images/katakana/o.png",
    romajiImageUrl: "lib/assets/images/romaji/o.png",
  ),
  const KanaModel(
    id: 82,
    kana: "カ",
    romaji: "ka",
    imageUrl: "lib/assets/images/katakana/ka.png",
    romajiImageUrl: "lib/assets/images/romaji/ka.png",
  ),
  const KanaModel(
    id: 83,
    kana: "キ",
    romaji: "ki",
    imageUrl: "lib/assets/images/katakana/ki.png",
    romajiImageUrl: "lib/assets/images/romaji/ki.png",
  ),
  const KanaModel(
    id: 84,
    kana: "ク",
    romaji: "ku",
    imageUrl: "lib/assets/images/katakana/ku.png",
    romajiImageUrl: "lib/assets/images/romaji/ku.png",
  ),
  const KanaModel(
    id: 85,
    kana: "ケ",
    romaji: "ke",
    imageUrl: "lib/assets/images/katakana/ke.png",
    romajiImageUrl: "lib/assets/images/romaji/ke.png",
  ),
  const KanaModel(
    id: 86,
    kana: "コ",
    romaji: "ko",
    imageUrl: "lib/assets/images/katakana/ko.png",
    romajiImageUrl: "lib/assets/images/romaji/ko.png",
  ),
  const KanaModel(
    id: 87,
    kana: "サ",
    romaji: "sa",
    imageUrl: "lib/assets/images/katakana/sa.png",
    romajiImageUrl: "lib/assets/images/romaji/sa.png",
  ),
  const KanaModel(
    id: 88,
    kana: "シ",
    romaji: "shi",
    imageUrl: "lib/assets/images/katakana/si.png",
    romajiImageUrl: "lib/assets/images/romaji/si.png",
  ),
  const KanaModel(
    id: 89,
    kana: "ス",
    romaji: "su",
    imageUrl: "lib/assets/images/katakana/su.png",
    romajiImageUrl: "lib/assets/images/romaji/su.png",
  ),
  const KanaModel(
    id: 90,
    kana: "セ",
    romaji: "se",
    imageUrl: "lib/assets/images/katakana/se.png",
    romajiImageUrl: "lib/assets/images/romaji/se.png",
  ),
  const KanaModel(
    id: 91,
    kana: "ソ",
    romaji: "so",
    imageUrl: "lib/assets/images/katakana/so.png",
    romajiImageUrl: "lib/assets/images/romaji/so.png",
  ),
  const KanaModel(
    id: 92,
    kana: "タ",
    romaji: "ta",
    imageUrl: "lib/assets/images/katakana/ta.png",
    romajiImageUrl: "lib/assets/images/romaji/ta.png",
  ),
  const KanaModel(
    id: 93,
    kana: "チ",
    romaji: "chi",
    imageUrl: "lib/assets/images/katakana/chi.png",
    romajiImageUrl: "lib/assets/images/romaji/chi.png",
  ),
  const KanaModel(
    id: 94,
    kana: "ツ",
    romaji: "tsu",
    imageUrl: "lib/assets/images/katakana/tsu.png",
    romajiImageUrl: "lib/assets/images/romaji/tsu.png",
  ),
  const KanaModel(
    id: 95,
    kana: "テ",
    romaji: "te",
    imageUrl: "lib/assets/images/katakana/te.png",
    romajiImageUrl: "lib/assets/images/romaji/te.png",
  ),
  const KanaModel(
    id: 96,
    kana: "ト",
    romaji: "to",
    imageUrl: "lib/assets/images/katakana/to.png",
    romajiImageUrl: "lib/assets/images/romaji/to.png",
  ),
  const KanaModel(
    id: 97,
    kana: "ナ",
    romaji: "na",
    imageUrl: "lib/assets/images/katakana/na.png",
    romajiImageUrl: "lib/assets/images/romaji/na.png",
  ),
  const KanaModel(
    id: 98,
    kana: "ニ",
    romaji: "ni",
    imageUrl: "lib/assets/images/katakana/ni.png",
    romajiImageUrl: "lib/assets/images/romaji/ni.png",
  ),
  const KanaModel(
    id: 99,
    kana: "ヌ",
    romaji: "nu",
    imageUrl: "lib/assets/images/katakana/nu.png",
    romajiImageUrl: "lib/assets/images/romaji/nu.png",
  ),
  const KanaModel(
    id: 100,
    kana: "ネ",
    romaji: "ne",
    imageUrl: "lib/assets/images/katakana/ne.png",
    romajiImageUrl: "lib/assets/images/romaji/ne.png",
  ),
  const KanaModel(
    id: 101,
    kana: "ノ",
    romaji: "no",
    imageUrl: "lib/assets/images/katakana/no.png",
    romajiImageUrl: "lib/assets/images/romaji/no.png",
  ),
  const KanaModel(
    id: 102,
    kana: "ハ",
    romaji: "ha",
    imageUrl: "lib/assets/images/katakana/ha.png",
    romajiImageUrl: "lib/assets/images/romaji/ha.png",
  ),
  const KanaModel(
    id: 103,
    kana: "ヒ",
    romaji: "hi",
    imageUrl: "lib/assets/images/katakana/hi.png",
    romajiImageUrl: "lib/assets/images/romaji/hi.png",
  ),
  const KanaModel(
    id: 104,
    kana: "フ",
    romaji: "fu",
    imageUrl: "lib/assets/images/katakana/fu.png",
    romajiImageUrl: "lib/assets/images/romaji/fu.png",
  ),
  const KanaModel(
    id: 105,
    kana: "ヘ",
    romaji: "he",
    imageUrl: "lib/assets/images/katakana/he.png",
    romajiImageUrl: "lib/assets/images/romaji/he.png",
  ),
  const KanaModel(
    id: 106,
    kana: "ホ",
    romaji: "ho",
    imageUrl: "lib/assets/images/katakana/ho.png",
    romajiImageUrl: "lib/assets/images/romaji/ho.png",
  ),
  const KanaModel(
    id: 107,
    kana: "マ",
    romaji: "ma",
    imageUrl: "lib/assets/images/katakana/ma.png",
    romajiImageUrl: "lib/assets/images/romaji/ma.png",
  ),
  const KanaModel(
    id: 108,
    kana: "ミ",
    romaji: "mi",
    imageUrl: "lib/assets/images/katakana/mi.png",
    romajiImageUrl: "lib/assets/images/romaji/mi.png",
  ),
  const KanaModel(
    id: 109,
    kana: "ム",
    romaji: "mu",
    imageUrl: "lib/assets/images/katakana/mu.png",
    romajiImageUrl: "lib/assets/images/romaji/mu.png",
  ),
  const KanaModel(
    id: 110,
    kana: "メ",
    romaji: "me",
    imageUrl: "lib/assets/images/katakana/me.png",
    romajiImageUrl: "lib/assets/images/romaji/me.png",
  ),
  const KanaModel(
    id: 111,
    kana: "モ",
    romaji: "mo",
    imageUrl: "lib/assets/images/katakana/mo.png",
    romajiImageUrl: "lib/assets/images/romaji/mo.png",
  ),
  const KanaModel(
    id: 112,
    kana: "ヤ",
    romaji: "ya",
    imageUrl: "lib/assets/images/katakana/ya.png",
    romajiImageUrl: "lib/assets/images/romaji/ya.png",
  ),
  const KanaModel(
    id: 113,
    kana: "ユ",
    romaji: "yu",
    imageUrl: "lib/assets/images/katakana/yu.png",
    romajiImageUrl: "lib/assets/images/romaji/yu.png",
  ),
  const KanaModel(
    id: 114,
    kana: "ヨ",
    romaji: "yo",
    imageUrl: "lib/assets/images/katakana/yo.png",
    romajiImageUrl: "lib/assets/images/romaji/yo.png",
  ),
  const KanaModel(
    id: 115,
    kana: "ラ",
    romaji: "ra",
    imageUrl: "lib/assets/images/katakana/ra.png",
    romajiImageUrl: "lib/assets/images/romaji/ra.png",
  ),
  const KanaModel(
    id: 116,
    kana: "リ",
    romaji: "ri",
    imageUrl: "lib/assets/images/katakana/ri.png",
    romajiImageUrl: "lib/assets/images/romaji/ri.png",
  ),
  const KanaModel(
    id: 117,
    kana: "ル",
    romaji: "ru",
    imageUrl: "lib/assets/images/katakana/ru.png",
    romajiImageUrl: "lib/assets/images/romaji/ru.png",
  ),
  const KanaModel(
    id: 118,
    kana: "レ",
    romaji: "re",
    imageUrl: "lib/assets/images/katakana/re.png",
    romajiImageUrl: "lib/assets/images/romaji/re.png",
  ),
  const KanaModel(
    id: 119,
    kana: "ロ",
    romaji: "ro",
    imageUrl: "lib/assets/images/katakana/ro.png",
    romajiImageUrl: "lib/assets/images/romaji/ro.png",
  ),
  const KanaModel(
    id: 120,
    kana: "ワ",
    romaji: "wa",
    imageUrl: "lib/assets/images/katakana/wa.png",
    romajiImageUrl: "lib/assets/images/romaji/wa.png",
  ),
  const KanaModel(
    id: 121,
    kana: "ヲ",
    romaji: "wo",
    imageUrl: "lib/assets/images/katakana/wo.png",
    romajiImageUrl: "lib/assets/images/romaji/wo.png",
  ),
  const KanaModel(
    id: 122,
    kana: "ン",
    romaji: "n",
    imageUrl: "lib/assets/images/katakana/n.png",
    romajiImageUrl: "lib/assets/images/romaji/n.png",
  ),
  const KanaModel(
    id: 123,
    kana: "ガ",
    romaji: "ga",
    imageUrl: "lib/assets/images/katakana/ga.png",
    romajiImageUrl: "lib/assets/images/romaji/ga.png",
  ),
  const KanaModel(
    id: 124,
    kana: "ギ",
    romaji: "gi",
    imageUrl: "lib/assets/images/katakana/gi.png",
    romajiImageUrl: "lib/assets/images/romaji/gi.png",
  ),
  const KanaModel(
    id: 125,
    kana: "グ",
    romaji: "gu",
    imageUrl: "lib/assets/images/katakana/gu.png",
    romajiImageUrl: "lib/assets/images/romaji/gu.png",
  ),
  const KanaModel(
    id: 126,
    kana: "ゲ",
    romaji: "ge",
    imageUrl: "lib/assets/images/katakana/ge.png",
    romajiImageUrl: "lib/assets/images/romaji/ge.png",
  ),
  const KanaModel(
    id: 127,
    kana: "ゴ",
    romaji: "go",
    imageUrl: "lib/assets/images/katakana/go.png",
    romajiImageUrl: "lib/assets/images/romaji/go.png",
  ),
  const KanaModel(
    id: 128,
    kana: "ザ",
    romaji: "za",
    imageUrl: "lib/assets/images/katakana/za.png",
    romajiImageUrl: "lib/assets/images/romaji/za.png",
  ),
  const KanaModel(
    id: 129,
    kana: "ジ",
    romaji: "ji",
    imageUrl: "lib/assets/images/katakana/ji.png",
    romajiImageUrl: "lib/assets/images/romaji/ji.png",
  ),
  const KanaModel(
    id: 130,
    kana: "ズ",
    romaji: "zu",
    imageUrl: "lib/assets/images/katakana/zu.png",
    romajiImageUrl: "lib/assets/images/romaji/zu.png",
  ),
  const KanaModel(
    id: 131,
    kana: "ゼ",
    romaji: "ze",
    imageUrl: "lib/assets/images/katakana/ze.png",
    romajiImageUrl: "lib/assets/images/romaji/ze.png",
  ),
  const KanaModel(
    id: 132,
    kana: "ゾ",
    romaji: "zo",
    imageUrl: "lib/assets/images/katakana/zo.png",
    romajiImageUrl: "lib/assets/images/romaji/zo.png",
  ),
  const KanaModel(
    id: 133,
    kana: "ダ",
    romaji: "da",
    imageUrl: "lib/assets/images/katakana/da.png",
    romajiImageUrl: "lib/assets/images/romaji/da.png",
  ),
  const KanaModel(
    id: 134,
    kana: "ヂ",
    romaji: "ji, dji, jyi",
    imageUrl: "lib/assets/images/katakana/dji.png",
    romajiImageUrl: "lib/assets/images/romaji/dji.png",
  ),
  const KanaModel(
    id: 135,
    kana: "ヅ",
    romaji: "dzu, zu",
    imageUrl: "lib/assets/images/katakana/dzu.png",
    romajiImageUrl: "lib/assets/images/romaji/dzu.png",
  ),
  const KanaModel(
    id: 136,
    kana: "デ",
    romaji: "de",
    imageUrl: "lib/assets/images/katakana/de.png",
    romajiImageUrl: "lib/assets/images/romaji/de.png",
  ),
  const KanaModel(
    id: 137,
    kana: "ド",
    romaji: "do",
    imageUrl: "lib/assets/images/katakana/do.png",
    romajiImageUrl: "lib/assets/images/romaji/do.png",
  ),
  const KanaModel(
    id: 138,
    kana: "バ",
    romaji: "ba",
    imageUrl: "lib/assets/images/katakana/ba.png",
    romajiImageUrl: "lib/assets/images/romaji/ba.png",
  ),
  const KanaModel(
    id: 139,
    kana: "ビ",
    romaji: "bi",
    imageUrl: "lib/assets/images/katakana/bi.png",
    romajiImageUrl: "lib/assets/images/romaji/bi.png",
  ),
  const KanaModel(
    id: 140,
    kana: "ブ",
    romaji: "bu",
    imageUrl: "lib/assets/images/katakana/bu.png",
    romajiImageUrl: "lib/assets/images/romaji/bu.png",
  ),
  const KanaModel(
    id: 141,
    kana: "ベ",
    romaji: "be",
    imageUrl: "lib/assets/images/katakana/be.png",
    romajiImageUrl: "lib/assets/images/romaji/be.png",
  ),
  const KanaModel(
    id: 142,
    kana: "ボ",
    romaji: "bo",
    imageUrl: "lib/assets/images/katakana/bo.png",
    romajiImageUrl: "lib/assets/images/romaji/bo.png",
  ),
  const KanaModel(
    id: 143,
    kana: "パ",
    romaji: "pa",
    imageUrl: "lib/assets/images/katakana/pa.png",
    romajiImageUrl: "lib/assets/images/romaji/pa.png",
  ),
  const KanaModel(
    id: 144,
    kana: "ピ",
    romaji: "pi",
    imageUrl: "lib/assets/images/katakana/pi.png",
    romajiImageUrl: "lib/assets/images/romaji/pi.png",
  ),
  const KanaModel(
    id: 145,
    kana: "プ",
    romaji: "pu",
    imageUrl: "lib/assets/images/katakana/pu.png",
    romajiImageUrl: "lib/assets/images/romaji/pu.png",
  ),
  const KanaModel(
    id: 146,
    kana: "ペ",
    romaji: "pe",
    imageUrl: "lib/assets/images/katakana/pe.png",
    romajiImageUrl: "lib/assets/images/romaji/pe.png",
  ),
  const KanaModel(
    id: 147,
    kana: "ポ",
    romaji: "po",
    imageUrl: "lib/assets/images/katakana/po.png",
    romajiImageUrl: "lib/assets/images/romaji/po.png",
  ),
  const KanaModel(
    id: 148,
    kana: "ャ",
    romaji: "x ya",
    imageUrl: "lib/assets/images/katakana/x0.png",
    romajiImageUrl: "lib/assets/images/romaji/x0.png",
  ),
  const KanaModel(
    id: 149,
    kana: "ュ",
    romaji: "x yu",
    imageUrl: "lib/assets/images/katakana/x1.png",
    romajiImageUrl: "lib/assets/images/romaji/x1.png",
  ),
  const KanaModel(
    id: 150,
    kana: "ョ",
    romaji: "x yo",
    imageUrl: "lib/assets/images/katakana/x2.png",
    romajiImageUrl: "lib/assets/images/romaji/x2.png",
  ),
  const KanaModel(
    id: 151,
    kana: "ッ",
    romaji: "x tsu",
    imageUrl: "lib/assets/images/katakana/x3.png",
    romajiImageUrl: "lib/assets/images/romaji/x3.png",
  ),
  const KanaModel(
    id: 152,
    kana: "ヽ",
    romaji: "x rep",
    imageUrl: "lib/assets/images/katakana/x4.png",
    romajiImageUrl: "lib/assets/images/romaji/x4.png",
  ),
  const KanaModel(
    id: 153,
    kana: "ヾ",
    romaji: "x rep2",
    imageUrl: "lib/assets/images/katakana/x5.png",
    romajiImageUrl: "lib/assets/images/romaji/x5.png",
  ),
  const KanaModel(
    id: 154,
    kana: "ー",
    romaji: "x pro",
    imageUrl: "lib/assets/images/katakana/x6.png",
    romajiImageUrl: "lib/assets/images/romaji/x6.png",
  ),
  const KanaModel(
    id: 155,
    kana: "ァ",
    romaji: "x a",
    imageUrl: "lib/assets/images/katakana/x7.png",
    romajiImageUrl: "lib/assets/images/romaji/x7.png",
  ),
  const KanaModel(
    id: 156,
    kana: "ィ",
    romaji: "x i",
    imageUrl: "lib/assets/images/katakana/x8.png",
    romajiImageUrl: "lib/assets/images/romaji/x8.png",
  ),
  const KanaModel(
    id: 157,
    kana: "ゥ",
    romaji: "x u",
    imageUrl: "lib/assets/images/katakana/x9.png",
    romajiImageUrl: "lib/assets/images/romaji/x9.png",
  ),
  const KanaModel(
    id: 158,
    kana: "ェ",
    romaji: "x e",
    imageUrl: "lib/assets/images/katakana/x10.png",
    romajiImageUrl: "lib/assets/images/romaji/x10.png",
  ),
  const KanaModel(
    id: 159,
    kana: "ォ",
    romaji: "x o",
    imageUrl: "lib/assets/images/katakana/x11.png",
    romajiImageUrl: "lib/assets/images/romaji/x11.png",
  ),
];
