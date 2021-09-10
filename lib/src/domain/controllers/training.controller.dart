import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_to_writer.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/domain/core/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/domain/core/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.repository.dart';
import 'package:kana_plus_plus/src/domain/support/kana_checker.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_viewer_content.dart';

class TrainingController {
  TrainingController({
    required this.wordRepository,
    required this.kanaChecker,
    required this.kanaType,
    required this.quantityOfWords,
  });

  final IWordRepository wordRepository;
  final IKanaChecker kanaChecker;

  final KanaType kanaType;
  final int quantityOfWords;

  int wordIdx = 0;
  int kanaIdx = 0;

  List<WordViewerContent> wordsToTraining = [];

  Future<bool> get isReady async {
    await kanaChecker.load();
    _generateDataForTest();
    return true;
  }

  String get wordImageUrl => wordsToTraining[wordIdx].imageUrl;

  int get numberOfWordsToStudy => wordsToTraining.length;

  KanaToWrite get currentKanaToWrite => KanaToWrite(
        id: wordsToTraining[wordIdx].kanas[kanaIdx].id,
        type: wordsToTraining[wordIdx].kanas[kanaIdx].kanaType,
        hintImageUrl: wordsToTraining[wordIdx].kanas[kanaIdx].kanaImageUrl,
        maxStrokes: wordsToTraining[wordIdx].kanas[kanaIdx].strokesQuantity,
      );

  int maxKanasOfWord(int currentWordIdx) => wordsToTraining[currentWordIdx].kanas.length;

  KanaViewerContent kanaOfWord(int currentWordIdx, int currentKanaIdx) => wordsToTraining[currentWordIdx].kanas[currentKanaIdx];

  UpdateKanaSituation updateKana(List<List<Offset>> strokesNormalized, String kanaIdWrote) {
    //print(strokesNormalized);
    //print(kanaIdWrote);
    // gera o que o kana viewer vai mostrar após escrito kana writer
    final preview = wordsToTraining[wordIdx].kanas[kanaIdx];
    wordsToTraining[wordIdx].kanas[kanaIdx] = KanaViewerContent(
      id: preview.id,
      status: (kanaIdWrote == preview.id) ? KanaViewerStatus.showCorrect : KanaViewerStatus.showWrong,
      romaji: preview.romaji,
      kanaImageUrl: preview.kanaImageUrl,
      strokesQuantity: preview.strokesQuantity,
      kanaType: preview.kanaType,
      kanaIdWrote: kanaIdWrote,
      strokesDrew: strokesNormalized,
    );

    // muda para o próximo kana
    kanaIdx++;
    UpdateKanaSituation situation = UpdateKanaSituation.changeKana;

    // atualiza o kana viewer do próximo
    if (kanaIdx < wordsToTraining[wordIdx].kanas.length) {
      final preview2 = wordsToTraining[wordIdx].kanas[kanaIdx];
      wordsToTraining[wordIdx].kanas[kanaIdx] = KanaViewerContent(
        id: preview2.id,
        status: KanaViewerStatus.showSelected,
        romaji: preview2.romaji,
        kanaImageUrl: preview2.kanaImageUrl,
        strokesQuantity: preview2.strokesQuantity,
        kanaType: preview2.kanaType,
      );
    }
    // caso tenha sido a ultima kana do word
    else {
      kanaIdx = 0;
      wordIdx += 1;
      situation = UpdateKanaSituation.changeWord;
    }

    if (wordIdx >= wordsToTraining.length) {
      situation = UpdateKanaSituation.changeTheLastWord;
    }
    return situation;
  }

  List<WordResult> get wordsResult {
    final List<WordResult> wordsResult = [];
    for (int w = 0; w < wordsToTraining.length; w++) {
      final List<KanaResult> kanasResult = [];
      for (int k = 0; k < wordsToTraining[w].kanas.length; k++) {
        final kanaContent = wordsToTraining[w].kanas[k];
        kanasResult.add(
          KanaResult(
            isCorrect: kanaContent.status.isShowCorrect,
            id: kanaContent.id,
            idWrote: kanaContent.kanaIdWrote,
            strokesDrew: kanaContent.strokesDrew,
          ),
        );
      }
      wordsResult.add(WordResult(
        id: wordsToTraining[w].id,
        imageUrl: wordsToTraining[w].imageUrl,
        kanas: kanasResult,
      ));
    }
    //print('wordsResult $wordsResult');
    return wordsResult;
  }

  // TEST /////////////////////////////////////////////////////////////////////
  void _generateDataForTest() {
    final List<Word> words = wordRepository.getWordsByIds(_generateRandomIds());

    for (int w = 0; w < words.length; w++) {
      final List<KanaViewerContent> kanas = [];
      for (int k = 0; k < words[w].kanas.length; k++) {
        kanas.add(
          KanaViewerContent(
            id: words[w].kanas[k].id,
            status: (k == 0) ? KanaViewerStatus.showSelected : KanaViewerStatus.showInitial,
            kanaImageUrl: words[w].kanas[k].imageUrl,
            romaji: words[w].kanas[k].romaji,
            strokesQuantity: words[w].kanas[k].strokesQuantity,
            kanaType: words[w].kanas[k].type,
          ),
        );
      }
      wordsToTraining.add(WordViewerContent(
        id: words[w].id,
        imageUrl: words[w].imageUrl,
        kanas: kanas,
      ));
    }

    //print('_generateDataForTest -> wordsToTraining $wordsToTraining');
  }

  List<String> _generateRandomIds() {
    final List<int> randomIds = [];
    for (int i = 0; i < quantityOfWords; i++) {
      int randomId = -1;
      bool ok = false;
      while (!ok) {
        randomId = Random().nextInt(testListWords.length);
        if (!randomIds.contains(randomId)) {
          ok = true;
        }
      }
      randomIds.add(randomId);
    }

    final List<String> randomIds2 = [];
    for (final numberId in randomIds) {
      randomIds2.add(testListWords[numberId]);
    }
    return randomIds2;
  }
  // TEST /////////////////////////////////////////////////////////////////////
}

final testListWords = [
  'ねこ',
  'いぬ',
  'とり',
  'うさぎ',
  'うし',
  'うま',
  'ひつじ',
  'やぎ',
  'ぶた',
  'むし',
  'はち',
  'くも',
  'あり',
  'さかな',
  'かめ',
  'へび',
  'わに',
  'えび',
  'かえる',
  'ひ',
  'つき',
  'やま',
  'どうくつ',
  'しま',
  'うみ',
  'かわ',
  'いけ',
  'たき',
  'き',
  'もり',
  'はな',
  'はる',
  'なつ',
  'あき',
  'ふゆ',
  'ゆき',
  'あめ',
  'あらし',
  'にじ',
  'べんとう',
  'さしみ',
  'すし',
  'みそしる',
  'ラーメン',
  'にく',
  'ソーセージ',
  'たまご',
  'はちみつ',
  'にんじん',
  'にんにく',
  'レタス',
  'ブロッコリー',
  'カリフラワー',
  'トマト',
  'じゃがいも',
  'なす',
  'きのこ',
  'かぼちゃ',
  'ピーナッツ',
  'りんご',
  'オレンジ',
  'バナナ',
  'すいか',
  'いちご',
  'パイナップル',
  'ぶどう',
  'チェリー',
  'メロン',
  'ココナッツ',
  'アボカド',
  'みず',
  'コーヒー',
  'おちゃ',
  'ぎゅうにゅう',
  'おさけ',
  'ワイン',
  'ビール',
  'くるま',
  'タクシー',
  'バス',
  'トラック',
  'バイク',
  'じてんしゃ',
  'でんしゃ',
  'ちかてつ',
  'ふね',
  'ボート',
  'ひこうき',
  'ヘリコプター',
  'ロケット',
  'えき',
  'くうこう',
  'みなと',
  'ぎんこう',
  'びょういん',
  'がっこう',
  'としょかん',
  'ホテル',
  'こうじょう',
  'きょうかい',
  'どうぶつえん',
  'みせ',
  'やっきょく',
  'バー',
  'デパート',
  'スーパー',
  'きっさてん',
  'レストラン',
  'ノート',
  'えんぴつ',
  'けしゴム',
  'ペン',
  'ほん',
  'つくえ',
  'かみ',
  'はさみ',
  'コンピューター',
  'スマートフォン',
  'でんわ',
  'エーティーエム',
  'いえ',
  'しんしつ',
  'だいどころ',
  'トイレ',
  'ドア',
  'かぎ',
  'まど',
  'たんす',
  'いす',
  'ソファー',
  'ベッド',
  'れいぞうこ',
  'せんたくき',
  'テレビ',
  'アイロン',
  'エアコン',
  'せんぷうき',
  'でんしレンジ',
  'ストーブ',
  'はし',
  'グラス',
  'スプーン',
  'フォーク',
  'しょくどう',
  'タオル',
  'シャワー',
  'せっけん',
  'シャンプー',
  'はみがきこ',
  'ティシャツ',
  'コート',
  'レインコート',
  'パンツ',
  'ジャケット',
  'ドレス',
  'ショーツ',
  'ジーパン',
  'イヤリング',
  'ネックレス',
  'ベルト',
  'スリッパ',
  'サンダル',
  'ブーツ',
  'アメリカ',
  'アルゼンチン',
  'オーストラリア',
  'ブラジル',
  'チリ',
  'エジプト',
  'フランス',
  'ドイツ',
  'イギリス',
  'イタリア',
  'にほん',
  'メキシコ',
  'モロッコ',
  'ニュージーランド',
  'ナイジェリア',
  'フィリピン',
  'ポルトガル',
  'ロシア',
  'みなみアフリカ',
  'かんこく',
  'スペイン',
  'タイ',
  'トルコ',
  'やきゅう',
  'すいえい',
  'ピンポン',
  'サッカー',
  'テニス',
  'バスケットボール',
  'バレーボール',
  'フットボール',
  'ラグビー',
  'ボクシング',
  'しろ',
  'くろ',
  'あか',
  'あお',
  'みどり',
  'きいろ',
  'ちゃいろ',
  'きんいろ',
  'ぎんいろ',
  'ももいろ',
  'だいだいいろ',
  'アイスクリーム',
  'バター',
  'ボタン',
  'チケット',
  'パン',
  'ピザ',
  'ポテチ',
  'サンドイッチ',
  'サラダ',
];
