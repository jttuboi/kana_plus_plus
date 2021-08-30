import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_type.dart';
import 'package:kana_plus_plus/src/domain/enums/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/domain/enums/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/repositories/word.interface.repository.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_viewer_content.dart';

class TrainingController {
  TrainingController({
    required this.wordRepository,
    required this.kanaType,
    required this.quantityOfWords,
  });

  IWordRepository wordRepository;

  KanaType kanaType;
  int quantityOfWords;

  int wordIdx = 0;
  int kanaIdx = 0;

  List<WordViewerContent> wordsToTraining = [];

  bool get isReady {
    _generateDataForTest();
    return true;
  }

  String get quitIconUrl => IconUrl.quitTraining;

  String get squareImageUrl => ImageUrl.square;

  String get correctImageUrl => ImageUrl.correct;

  String get wrongImageUrl => ImageUrl.wrong;

  String get currentImageUrl => wordsToTraining[wordIdx].imageUrl;

  int get currentKanaMaxStrokes => wordsToTraining[wordIdx].kanas[kanaIdx].strokesQuantity;

  String get currentKanaImageUrl => wordsToTraining[wordIdx].kanas[kanaIdx].kanaImageUrl;

  KanaType get currentKanaType => wordsToTraining[wordIdx].kanas[kanaIdx].kanaType;

  int getMaxKanasOfWord(int currentWordIdx) {
    return wordsToTraining[currentWordIdx].kanas.length;
  }

  KanaViewerContent kanaOfWord(int currentWordIdx, int currentKanaIdx) {
    return wordsToTraining[currentWordIdx].kanas[currentKanaIdx];
  }

  UpdateKanaSituation updateKana(List<List<Offset>> strokesNormalized, String kanaIdWrote) {
    // gera o que o kana viewer vai mostrar após escrito kana writer
    final preview = wordsToTraining[wordIdx].kanas[kanaIdx];
    wordsToTraining[wordIdx].kanas[kanaIdx] = KanaViewerContent(
        id: preview.id,
        status: (kanaIdWrote == preview.id) ? KanaViewerStatus.showCorrect : KanaViewerStatus.showWrong,
        romajiImageUrl: preview.romajiImageUrl,
        kanaImageUrl: preview.kanaImageUrl,
        strokesQuantity: preview.strokesQuantity,
        kanaType: preview.kanaType,
        kanaIdWrote: kanaIdWrote,
        strokesDrew: strokesNormalized);

    // muda para o próximo kana
    kanaIdx++;
    UpdateKanaSituation situation = UpdateKanaSituation.changeKana;

    // atualiza o kana viewer do próximo
    if (kanaIdx < wordsToTraining[wordIdx].kanas.length) {
      final preview2 = wordsToTraining[wordIdx].kanas[kanaIdx];
      wordsToTraining[wordIdx].kanas[kanaIdx] = KanaViewerContent(
        id: preview2.id,
        status: KanaViewerStatus.showSelected,
        romajiImageUrl: preview2.romajiImageUrl,
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
            imageUrl: kanaContent.kanaImageUrl,
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
            romajiImageUrl: words[w].kanas[k].romajiImageUrl,
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
  'しょくど',
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
