import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';

void main() {
  final mockWordsBloc = MockWordsBloc();

  group('FilteredWordsBloc', () {
    blocTest<FilteredWordsBloc, FilteredWordsState>(
      'emits [FilteredWordsLoadSuccess] when WordsUpdated is added',
      setUp: () => when(() => mockWordsBloc.state).thenReturn(const WordsLoadSuccess(words)),
      build: () => FilteredWordsBloc(wordsBloc: mockWordsBloc),
      act: (bloc) => bloc.add(const WordsUpdated(words)),
      expect: () => const [FilteredWordsLoadSuccess(filteredWords: words, currentFilter: Filter.all)],
    );

    blocTest<FilteredWordsBloc, FilteredWordsState>(
      'emits [FilteredWordsLoadSuccess] with Filter.searched and only words filtered when FilterUpdated is added',
      setUp: () => when(() => mockWordsBloc.state).thenReturn(const WordsLoadSuccess(words)),
      build: () => FilteredWordsBloc(wordsBloc: mockWordsBloc),
      act: (bloc) => bloc.add(const FilterUpdated(Filter.searched, 'し')),
      expect: () => [FilteredWordsLoadSuccess(filteredWords: words.where((word) => word.id.contains('し')).toList(), currentFilter: Filter.searched)],
    );
  });
}

const words = [
  WordViewModel(
    id: 'あめ',
    romaji: 'ame',
    kanaType: KanaType.hiragana,
    imageUrl: 'rain.png',
    translate: 'chuva',
    kanas: [
      KanaViewModel(id: 'あ', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'め', kanaType: KanaType.hiragana, romaji: 'me', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'けしゴム',
    romaji: 'keshigomu',
    kanaType: KanaType.hiragana,
    imageUrl: 'eraser.png',
    translate: 'borracha',
    kanas: [
      KanaViewModel(id: 'け', kanaType: KanaType.hiragana, romaji: 'ke', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ゴ', kanaType: KanaType.katakana, romaji: 'go', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ム', kanaType: KanaType.katakana, romaji: 'mu', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'サラダ',
    romaji: 'sarada',
    kanaType: KanaType.hiragana,
    imageUrl: 'salad.png',
    translate: 'salada',
    kanas: [
      KanaViewModel(id: 'サ', kanaType: KanaType.katakana, romaji: 'sa', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ラ', kanaType: KanaType.katakana, romaji: 'ra', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ダ', kanaType: KanaType.katakana, romaji: 'da', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'うし',
    romaji: 'ushi',
    kanaType: KanaType.hiragana,
    imageUrl: 'cow.png',
    translate: 'vaca',
    kanas: [
      KanaViewModel(id: 'う', kanaType: KanaType.hiragana, romaji: 'u', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'うま',
    romaji: 'uma',
    kanaType: KanaType.hiragana,
    imageUrl: 'horse.png',
    translate: 'cavalo',
    kanas: [
      KanaViewModel(id: 'う', kanaType: KanaType.hiragana, romaji: 'u', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ま', kanaType: KanaType.hiragana, romaji: 'ma', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'しま',
    romaji: 'shima',
    kanaType: KanaType.hiragana,
    imageUrl: 'island.png',
    translate: 'ilha',
    kanas: [
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ま', kanaType: KanaType.hiragana, romaji: 'ma', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'あらし',
    romaji: 'arashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'storm.png',
    translate: 'tempestada',
    kanas: [
      KanaViewModel(id: 'あ', kanaType: KanaType.hiragana, romaji: 'a', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ら', kanaType: KanaType.hiragana, romaji: 'ra', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'しろ',
    romaji: 'shiro',
    kanaType: KanaType.hiragana,
    imageUrl: 'white.png',
    translate: 'branco',
    kanas: [
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'ろ', kanaType: KanaType.hiragana, romaji: 'ro', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
  WordViewModel(
    id: 'はし',
    romaji: 'hashi',
    kanaType: KanaType.hiragana,
    imageUrl: 'hashi.png',
    translate: 'chopsticks',
    kanas: [
      KanaViewModel(id: 'は', kanaType: KanaType.hiragana, romaji: 'ha', strokes: [], correctCount: 0, wrongCount: 0),
      KanaViewModel(id: 'し', kanaType: KanaType.hiragana, romaji: 'shi', strokes: [], correctCount: 0, wrongCount: 0),
    ],
    correctCount: 0,
    wrongCount: 0,
  ),
];
