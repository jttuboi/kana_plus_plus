// ignore_for_file: avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  group('WordBloc', () {
    final mockListBloc = MockListBloc();

    blocTest<WordBloc, WordState>(
      'emits [WordUpdated] when WordUpdated is added and listBloc state is ListWordReady',
      setUp: () => when(() => mockListBloc.state).thenReturn(const ListReady(kanaIndex: 0, wordIndex: 2, words: wordsViewModel)),
      build: () => WordBloc(mockListBloc),
      act: (bloc) => bloc.add(const WordUpdated(wordIndex: 2, words: wordsViewModel)),
      expect: () => [WordReady(index: 2, total: wordsViewModel.length, translate: wordsViewModel[2].translate, imageUrl: wordsViewModel[2].imageUrl)],
    );
  });
}

const wordsViewModel = [
  WordViewModel(
    id: 'あめ',
    imageUrl: 'rain.png',
    translate: 'chuva',
    kanas: [
      KanaViewModel(id: 'あ', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'a', strokes: []),
      KanaViewModel(id: 'め', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'me', strokes: []),
    ],
  ),
  WordViewModel(
    id: 'あらし',
    imageUrl: 'storm.png',
    translate: 'tempestada',
    kanas: [
      KanaViewModel(id: 'あ', status: KanaViewerStatus.correct, kanaType: KanaType.hiragana, romaji: 'a', strokes: []),
      KanaViewModel(id: 'ら', status: KanaViewerStatus.wrong, kanaType: KanaType.hiragana, romaji: 'ra', strokes: []),
      KanaViewModel(id: 'し', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'shi', strokes: []),
    ],
  ),
  WordViewModel(
    id: 'うし',
    imageUrl: 'cow.png',
    translate: 'vaca',
    kanas: [
      KanaViewModel(id: 'う', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'u', strokes: []),
      KanaViewModel(id: 'し', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'shi', strokes: []),
    ],
  ),
  WordViewModel(
    id: 'うま',
    imageUrl: 'horse.png',
    translate: 'cavalo',
    kanas: [
      KanaViewModel(id: 'う', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'u', strokes: []),
      KanaViewModel(id: 'ま', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'ma', strokes: []),
    ],
  ),
  WordViewModel(
    id: 'けしゴム',
    imageUrl: 'eraser.png',
    translate: 'borracha',
    kanas: [
      KanaViewModel(id: 'け', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'ke', strokes: []),
      KanaViewModel(id: 'し', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'shi', strokes: []),
      KanaViewModel(id: 'ゴ', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'go', strokes: []),
      KanaViewModel(id: 'ム', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'mu', strokes: []),
    ],
  ),
  WordViewModel(
    id: 'しま',
    imageUrl: 'island.png',
    translate: 'ilha',
    kanas: [
      KanaViewModel(id: 'し', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'shi', strokes: []),
      KanaViewModel(id: 'ま', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'ma', strokes: []),
    ],
  ),
  WordViewModel(
    id: 'しろ',
    imageUrl: 'white.png',
    translate: 'branco',
    kanas: [
      KanaViewModel(id: 'し', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'shi', strokes: []),
      KanaViewModel(id: 'ろ', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'ro', strokes: []),
    ],
  ),
  WordViewModel(
    id: 'はし',
    imageUrl: 'hashi.png',
    translate: 'chopsticks',
    kanas: [
      KanaViewModel(id: 'は', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'ha', strokes: []),
      KanaViewModel(id: 'し', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'shi', strokes: []),
    ],
  ),
  WordViewModel(
    id: 'サラダ',
    imageUrl: 'salad.png',
    translate: 'salada',
    kanas: [
      KanaViewModel(id: 'サ', status: KanaViewerStatus.select, kanaType: KanaType.katakana, romaji: 'sa', strokes: []),
      KanaViewModel(id: 'ラ', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'ra', strokes: []),
      KanaViewModel(id: 'ダ', status: KanaViewerStatus.normal, kanaType: KanaType.katakana, romaji: 'da', strokes: []),
    ],
  ),
];
