import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/image_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/slqlite_database.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/domain/entities/update_kana_situation.dart';
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

  Future<bool> get isReady async {
    await _generateDataForTest();
    return true;
  }

  String get quitIconUrl => IconUrl.quitTraining;

  String get squareImageUrl => ImageUrl.square;

  String get correctImageUrl => ImageUrl.correct;

  String get wrongImageUrl => ImageUrl.wrong;

  String get currentImageUrl => wordsToTraining[wordIdx].imageUrl;

  int get currentKanaMaxStrokes => wordsToTraining[wordIdx].kanas[kanaIdx].strokesNumber;

  String get currentKanaImageUrl => wordsToTraining[wordIdx].kanas[kanaIdx].kanaImageUrl;

  KanaType get currentKanaType => wordsToTraining[wordIdx].kanas[kanaIdx].kanaType;

  int getMaxKanasOfWord(int currentWordIdx) {
    return wordsToTraining[currentWordIdx].kanas.length;
  }

  KanaViewerContent kanaOfWord(int currentWordIdx, int currentKanaIdx) {
    return wordsToTraining[currentWordIdx].kanas[currentKanaIdx];
  }

  UpdateKanaSituation updateKana(List<List<Offset>> strokesNormalized, int kanaIdWrote) {
    // gera o que o kana viewer vai mostrar após escrito kana writer
    final preview = wordsToTraining[wordIdx].kanas[kanaIdx];
    wordsToTraining[wordIdx].kanas[kanaIdx] = KanaViewerContent(
        id: preview.id,
        status: (kanaIdWrote == preview.id) ? KanaViewerStatus.showCorrect : KanaViewerStatus.showWrong,
        romajiImageUrl: preview.romajiImageUrl,
        kanaImageUrl: preview.kanaImageUrl,
        strokesNumber: preview.strokesNumber,
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
        strokesNumber: preview2.strokesNumber,
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
        text: wordsToTraining[w].text,
        imageUrl: wordsToTraining[w].imageUrl,
        kanas: kanasResult,
      ));
    }
    return wordsResult;
  }

  // TEST /////////////////////////////////////////////////////////////////////
  Future<void> _generateDataForTest() async {
    final List<Word> words = await wordRepository.getWordsByIds(
      _generateRandomIds(),
      kanaType,
    );

    for (int w = 0; w < words.length; w++) {
      final List<KanaViewerContent> kanas = [];
      for (int k = 0; k < words[w].kanas.length; k++) {
        kanas.add(
          KanaViewerContent(
            id: words[w].kanas[k].id,
            status: (k == 0) ? KanaViewerStatus.showSelected : KanaViewerStatus.showInitial,
            kanaImageUrl: words[w].kanas[k].imageUrl,
            romajiImageUrl: words[w].kanas[k].romajiImageUrl,
            strokesNumber: words[w].kanas[k].numberStrokes,
            kanaType: words[w].kanas[k].type,
          ),
        );
      }
      wordsToTraining.add(WordViewerContent(
        id: words[w].id,
        text: words[w].text,
        imageUrl: words[w].imageUrl,
        kanas: kanas,
      ));
    }
  }

  List<int> _generateRandomIds() {
    final List<int> randomIds = [];
    for (int i = 0; i < quantityOfWords; i++) {
      int randomId = -1;
      bool ok = false;
      while (!ok) {
        randomId = Random().nextInt(wordsTest.length);
        if (!randomIds.contains(randomId)) {
          ok = true;
        }
      }
      randomIds.add(randomId);
    }
    return randomIds;
  }
  // TEST /////////////////////////////////////////////////////////////////////
}
