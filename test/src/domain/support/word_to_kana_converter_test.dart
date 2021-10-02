import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/data/models/kana.model.dart';
import 'package:kana_plus_plus/src/domain/entities/kana.dart';
import 'package:kana_plus_plus/src/domain/support/word_to_kana_converter.dart';
import 'package:kana_plus_plus/src/domain/utils/kana_type.dart';

void main() {
  final converter = WordToKanaConverter();
  final kanasJson = <String, KanaModel>{};

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    return rootBundle.loadString('lib/assets/database/kanas.json').then((response) {
      final jsonFile = json.decode(response) as List<dynamic>;
      for (final jsonData in jsonFile) {
        final model = KanaModel.fromJson(jsonData as Map<String, dynamic>);
        kanasJson[model.id] = model;
      }
    });
  });
  group('check data', () {
    test('must check all data returned of word みなみアフリカ', () {
      final kanas = converter.convert('みなみアフリカ', kanasJson);

      expect(kanas[0].id, 'み');
      expect(kanas[0].romaji, 'mi');
      expect(kanas[0].imageUrl, '${ImageUrl.imageTestFolder}kanas/み.svg');
      expect(kanas[0].type, KanaType.hiragana);
      expect(kanas[0].strokesQuantity, 2);

      expect(kanas[1].id, 'な');
      expect(kanas[1].romaji, 'na');
      expect(kanas[1].imageUrl, '${ImageUrl.imageTestFolder}kanas/な.svg');
      expect(kanas[1].type, KanaType.hiragana);
      expect(kanas[1].strokesQuantity, 4);

      expect(kanas[2].id, 'み');
      expect(kanas[2].romaji, 'mi');
      expect(kanas[2].imageUrl, '${ImageUrl.imageTestFolder}kanas/み.svg');
      expect(kanas[2].type, KanaType.hiragana);
      expect(kanas[2].strokesQuantity, 2);

      expect(kanas[3].id, 'ア');
      expect(kanas[3].romaji, 'a');
      expect(kanas[3].imageUrl, '${ImageUrl.imageTestFolder}kanas/ア.svg');
      expect(kanas[3].type, KanaType.katakana);
      expect(kanas[3].strokesQuantity, 2);

      expect(kanas[4].id, 'フ');
      expect(kanas[4].romaji, 'fu');
      expect(kanas[4].imageUrl, '${ImageUrl.imageTestFolder}kanas/フ.svg');
      expect(kanas[4].type, KanaType.katakana);
      expect(kanas[4].strokesQuantity, 1);

      expect(kanas[5].id, 'リ');
      expect(kanas[5].romaji, 'ri');
      expect(kanas[5].imageUrl, '${ImageUrl.imageTestFolder}kanas/リ.svg');
      expect(kanas[5].type, KanaType.katakana);
      expect(kanas[5].strokesQuantity, 2);

      expect(kanas[6].id, 'カ');
      expect(kanas[6].romaji, 'ka');
      expect(kanas[6].imageUrl, '${ImageUrl.imageTestFolder}kanas/カ.svg');
      expect(kanas[6].type, KanaType.katakana);
      expect(kanas[6].strokesQuantity, 2);
    });
    test('must check all data returned of word ぎゅうにゅう', () {
      final kanas = converter.convert('ぎゅうにゅう', kanasJson);

      expect(kanas[0].id, 'ぎゅ');
      expect(kanas[0].romaji, 'gyu');
      expect(kanas[0].imageUrl, '${ImageUrl.imageTestFolder}kanas/ぎゅ.svg');
      expect(kanas[0].type, KanaType.hiragana);
      expect(kanas[0].strokesQuantity, 8);

      expect(kanas[1].id, 'う');
      expect(kanas[1].romaji, 'u');
      expect(kanas[1].imageUrl, '${ImageUrl.imageTestFolder}kanas/う.svg');
      expect(kanas[1].type, KanaType.hiragana);
      expect(kanas[1].strokesQuantity, 2);

      expect(kanas[2].id, 'にゅ');
      expect(kanas[2].romaji, 'nyu');
      expect(kanas[2].imageUrl, '${ImageUrl.imageTestFolder}kanas/にゅ.svg');
      expect(kanas[2].type, KanaType.hiragana);
      expect(kanas[2].strokesQuantity, 5);

      expect(kanas[3].id, 'う');
      expect(kanas[3].romaji, 'u');
      expect(kanas[3].imageUrl, '${ImageUrl.imageTestFolder}kanas/う.svg');
      expect(kanas[3].type, KanaType.hiragana);
      expect(kanas[3].strokesQuantity, 2);
    });
    test('must check all data returned of word やっきょく', () {
      final kanas = converter.convert('やっきょく', kanasJson);

      expect(kanas[0].id, 'や');
      expect(kanas[0].romaji, 'ya');
      expect(kanas[0].imageUrl, '${ImageUrl.imageTestFolder}kanas/や.svg');
      expect(kanas[0].type, KanaType.hiragana);
      expect(kanas[0].strokesQuantity, 3);

      expect(kanas[1].id, 'っ');
      expect(kanas[1].romaji, 'k');
      expect(kanas[1].imageUrl, '${ImageUrl.imageTestFolder}kanas/っ.svg');
      expect(kanas[1].type, KanaType.hiragana);
      expect(kanas[1].strokesQuantity, 1);

      expect(kanas[2].id, 'きょ');
      expect(kanas[2].romaji, 'kyo');
      expect(kanas[2].imageUrl, '${ImageUrl.imageTestFolder}kanas/きょ.svg');
      expect(kanas[2].type, KanaType.hiragana);
      expect(kanas[2].strokesQuantity, 6);

      expect(kanas[3].id, 'く');
      expect(kanas[3].romaji, 'ku');
      expect(kanas[3].imageUrl, '${ImageUrl.imageTestFolder}kanas/く.svg');
      expect(kanas[3].type, KanaType.hiragana);
      expect(kanas[3].strokesQuantity, 1);
    });
    test('must check all data returned of word ニュージーランド', () {
      final kanas = converter.convert('ニュージーランド', kanasJson);

      expect(kanas[0].id, 'ニュ');
      expect(kanas[0].romaji, 'nyu');
      expect(kanas[0].imageUrl, '${ImageUrl.imageTestFolder}kanas/ニュ.svg');
      expect(kanas[0].type, KanaType.katakana);
      expect(kanas[0].strokesQuantity, 4);

      expect(kanas[1].id, 'ー');
      expect(kanas[1].romaji, 'u');
      expect(kanas[1].imageUrl, '${ImageUrl.imageTestFolder}kanas/ー.svg');
      expect(kanas[1].type, KanaType.katakana);
      expect(kanas[1].strokesQuantity, 1);

      expect(kanas[2].id, 'ジ');
      expect(kanas[2].romaji, 'ji');
      expect(kanas[2].imageUrl, '${ImageUrl.imageTestFolder}kanas/ジ.svg');
      expect(kanas[2].type, KanaType.katakana);
      expect(kanas[2].strokesQuantity, 5);

      expect(kanas[3].id, 'ー');
      expect(kanas[3].romaji, 'i');
      expect(kanas[3].imageUrl, '${ImageUrl.imageTestFolder}kanas/ー.svg');
      expect(kanas[3].type, KanaType.katakana);
      expect(kanas[3].strokesQuantity, 1);

      expect(kanas[4].id, 'ラ');
      expect(kanas[4].romaji, 'ra');
      expect(kanas[4].imageUrl, '${ImageUrl.imageTestFolder}kanas/ラ.svg');
      expect(kanas[4].type, KanaType.katakana);
      expect(kanas[4].strokesQuantity, 2);

      expect(kanas[5].id, 'ン');
      expect(kanas[5].romaji, 'n');
      expect(kanas[5].imageUrl, '${ImageUrl.imageTestFolder}kanas/ン.svg');
      expect(kanas[5].type, KanaType.katakana);
      expect(kanas[5].strokesQuantity, 2);

      expect(kanas[6].id, 'ド');
      expect(kanas[6].romaji, 'do');
      expect(kanas[6].imageUrl, '${ImageUrl.imageTestFolder}kanas/ド.svg');
      expect(kanas[6].type, KanaType.katakana);
      expect(kanas[6].strokesQuantity, 4);
    });
  });
  group('check hiragana ids and romajis', () {
    test('must check id and romaji with gojuuon samples', () {
      expectKR(converter.convert('ひ', kanasJson), kanasE: [KE('ひ', 'hi')]);
      expectKR(converter.convert('あき', kanasJson), kanasE: [KE('あ', 'a'), KE('き', 'ki')]);
      expectKR(converter.convert('ももいろ', kanasJson), kanasE: [KE('も', 'mo'), KE('も', 'mo'), KE('い', 'i'), KE('ろ', 'ro')]);
      expectKR(converter.convert('すいか', kanasJson), kanasE: [KE('す', 'su'), KE('い', 'i'), KE('か', 'ka')]);
      expectKR(converter.convert('にんじん', kanasJson), kanasE: [KE('に', 'ni'), KE('ん', 'n'), KE('じ', 'ji'), KE('ん', 'n')]);
      expectKR(converter.convert('だいどころ', kanasJson), kanasE: [KE('だ', 'da'), KE('い', 'i'), KE('ど', 'do'), KE('こ', 'ko'), KE('ろ', 'ro')]);
      expectKR(converter.convert('だいだいいろ', kanasJson),
          kanasE: [KE('だ', 'da'), KE('い', 'i'), KE('だ', 'da'), KE('い', 'i'), KE('い', 'i'), KE('ろ', 'ro')]);
      expectKR(converter.convert('えんぴつ', kanasJson), kanasE: [KE('え', 'e'), KE('ん', 'n'), KE('ぴ', 'pi'), KE('つ', 'tsu')]);
      expectKR(converter.convert('せんぷうき', kanasJson), kanasE: [KE('せ', 'se'), KE('ん', 'n'), KE('ぷ', 'pu'), KE('う', 'u'), KE('き', 'ki')]);
    });
    test('must check id and romaji with youon samples', () {
      expectKR(converter.convert('ぎゅうにゅう', kanasJson), kanasE: [KE('ぎゅ', 'gyu'), KE('う', 'u'), KE('にゅ', 'nyu'), KE('う', 'u')]);
      expectKR(converter.convert('じてんしゃ', kanasJson), kanasE: [KE('じ', 'ji'), KE('て', 'te'), KE('ん', 'n'), KE('しゃ', 'sha')]);
      expectKR(converter.convert('かぼちゃ', kanasJson), kanasE: [KE('か', 'ka'), KE('ぼ', 'bo'), KE('ちゃ', 'cha')]);
      expectKR(converter.convert('びょういん', kanasJson), kanasE: [KE('びょ', 'byo'), KE('う', 'u'), KE('い', 'i'), KE('ん', 'n')]);
      expectKR(converter.convert('こうじょう', kanasJson), kanasE: [KE('こ', 'ko'), KE('う', 'u'), KE('じょ', 'jo'), KE('う', 'u')]);
      expectKR(converter.convert('しょくどう', kanasJson), kanasE: [KE('しょ', 'sho'), KE('く', 'ku'), KE('ど', 'do'), KE('う', 'u')]);
    });
    test('must check id and romaji with sokuon samples', () {
      expectKR(converter.convert('きっさてん', kanasJson), kanasE: [KE('き', 'ki'), KE('っ', 's'), KE('さ', 'sa'), KE('て', 'te'), KE('ん', 'n')]);
      expectKR(converter.convert('がっこう', kanasJson), kanasE: [KE('が', 'ga'), KE('っ', 'k'), KE('こ', 'ko'), KE('う', 'u')]);
      expectKR(converter.convert('せっけん', kanasJson), kanasE: [KE('せ', 'se'), KE('っ', 'k'), KE('け', 'ke'), KE('ん', 'n')]);
      expectKR(converter.convert('やっきょく', kanasJson), kanasE: [KE('や', 'ya'), KE('っ', 'k'), KE('きょ', 'kyo'), KE('く', 'ku')]);
    });
  });
  group('check katakana ids and romajis', () {
    test('must check id and romaji with gojuuon samples', () {
      expectKR(converter.convert('ロシア', kanasJson), kanasE: [KE('ロ', 'ro'), KE('シ', 'shi'), KE('ア', 'a')]);
      expectKR(converter.convert('タオル', kanasJson), kanasE: [KE('タ', 'ta'), KE('オ', 'o'), KE('ル', 'ru')]);
      expectKR(converter.convert('トルコ', kanasJson), kanasE: [KE('ト', 'to'), KE('ル', 'ru'), KE('コ', 'ko')]);
      expectKR(converter.convert('イヤリング', kanasJson), kanasE: [KE('イ', 'i'), KE('ヤ', 'ya'), KE('リ', 'ri'), KE('ン', 'n'), KE('グ', 'gu')]);
      expectKR(converter.convert('オレンジ', kanasJson), kanasE: [KE('オ', 'o'), KE('レ', 're'), KE('ン', 'n'), KE('ジ', 'ji')]);
      expectKR(converter.convert('ドア', kanasJson), kanasE: [KE('ド', 'do'), KE('ア', 'a')]);
      expectKR(converter.convert('ピンポン', kanasJson), kanasE: [KE('ピ', 'pi'), KE('ン', 'n'), KE('ポ', 'po'), KE('ン', 'n')]);
    });
    test('must check id and romaji with youon samples', () {
      expectKR(converter.convert('ジャケット', kanasJson), kanasE: [KE('ジャ', 'ja'), KE('ケ', 'ke'), KE('ッ', 't'), KE('ト', 'to')]);
      expectKR(converter.convert('シャンプー', kanasJson), kanasE: [KE('シャ', 'sha'), KE('ン', 'n'), KE('プ', 'pu'), KE('ー', 'u')]);
      expectKR(converter.convert('シャワー', kanasJson), kanasE: [KE('シャ', 'sha'), KE('ワ', 'wa'), KE('ー', 'a')]);
      expectKR(converter.convert('ニュージーランド', kanasJson),
          kanasE: [KE('ニュ', 'nyu'), KE('ー', 'u'), KE('ジ', 'ji'), KE('ー', 'i'), KE('ラ', 'ra'), KE('ン', 'n'), KE('ド', 'do')]);
      expectKR(converter.convert('コンピューター', kanasJson),
          kanasE: [KE('コ', 'ko'), KE('ン', 'n'), KE('ピュ', 'pyu'), KE('ー', 'u'), KE('タ', 'ta'), KE('ー', 'a')]);
      expectKR(converter.convert('ショーツ', kanasJson), kanasE: [KE('ショ', 'sho'), KE('ー', 'o'), KE('ツ', 'tsu')]);
    });
    test('must check id and romaji with sokuon samples', () {
      expectKR(converter.convert('ネックレス', kanasJson), kanasE: [KE('ネ', 'ne'), KE('ッ', 'k'), KE('ク', 'ku'), KE('レ', 're'), KE('ス', 'su')]);
      expectKR(converter.convert('ココナッツ', kanasJson), kanasE: [KE('コ', 'ko'), KE('コ', 'ko'), KE('ナ', 'na'), KE('ッ', 't'), KE('ツ', 'tsu')]);
      expectKR(converter.convert('ベッド', kanasJson), kanasE: [KE('ベ', 'be'), KE('ッ', 'd'), KE('ド', 'do')]);
      expectKR(converter.convert('ピーナッツ', kanasJson), kanasE: [KE('ピ', 'pi'), KE('ー', 'i'), KE('ナ', 'na'), KE('ッ', 't'), KE('ツ', 'tsu')]);
      expectKR(converter.convert('サッカー', kanasJson), kanasE: [KE('サ', 'sa'), KE('ッ', 'k'), KE('カ', 'ka'), KE('ー', 'a')]);
    });
    test('must check id and romaji with small vowel samples', () {
      expectKR(converter.convert('チェリー', kanasJson), kanasE: [KE('チェ', 'che'), KE('リ', 'ri'), KE('ー', 'i')]);
      expectKR(converter.convert('ソファー', kanasJson), kanasE: [KE('ソ', 'so'), KE('ファ', 'fa'), KE('ー', 'a')]);
      expectKR(converter.convert('エーティーエム', kanasJson),
          kanasE: [KE('エ', 'e'), KE('ー', 'e'), KE('ティ', 'ti'), KE('ー', 'i'), KE('エ', 'e'), KE('ム', 'mu')]);
      expectKR(converter.convert('フォーク', kanasJson), kanasE: [KE('フォ', 'fo'), KE('ー', 'o'), KE('ク', 'ku')]);
    });
    test('must check id and romaji with long vowel samples', () {
      expectKR(converter.convert('スプーン', kanasJson), kanasE: [KE('ス', 'su'), KE('プ', 'pu'), KE('ー', 'u'), KE('ン', 'n')]);
      expectKR(converter.convert('ブーツ', kanasJson), kanasE: [KE('ブ', 'bu'), KE('ー', 'u'), KE('ツ', 'tsu')]);
      expectKR(converter.convert('コーヒー', kanasJson), kanasE: [KE('コ', 'ko'), KE('ー', 'o'), KE('ヒ', 'hi'), KE('ー', 'i')]);
      expectKR(converter.convert('バレーボール', kanasJson),
          kanasE: [KE('バ', 'ba'), KE('レ', 're'), KE('ー', 'e'), KE('ボ', 'bo'), KE('ー', 'o'), KE('ル', 'ru')]);
    });
  });

  group('check both ids and romajis', () {
    test('must check id and romaji with hiragana and katakana syllabes', () {
      expectKR(converter.convert('けしゴム', kanasJson), kanasE: [KE('け', 'ke'), KE('し', 'shi'), KE('ゴ', 'go'), KE('ム', 'mu')]);
      expectKR(converter.convert('でんしレンジ', kanasJson),
          kanasE: [KE('で', 'de'), KE('ん', 'n'), KE('し', 'shi'), KE('レ', 're'), KE('ン', 'n'), KE('ジ', 'ji')]);
      expectKR(converter.convert('みなみアフリカ', kanasJson),
          kanasE: [KE('み', 'mi'), KE('な', 'na'), KE('み', 'mi'), KE('ア', 'a'), KE('フ', 'fu'), KE('リ', 'ri'), KE('カ', 'ka')]);
    });
  });
}

void expectKR(List<Kana> kanas, {required List<KE> kanasE}) {
  expect(kanas.length == kanasE.length, isTrue);
  for (int i = 0; i < kanasE.length; i++) {
    expect(kanas[i].id, kanasE[i].id);
    expect(kanas[i].romaji, kanasE[i].romaji);
  }
}

class KE {
  KE(this.id, this.romaji);

  final String id;
  final String romaji;
}
