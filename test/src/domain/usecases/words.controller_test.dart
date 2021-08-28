import 'package:flutter_test/flutter_test.dart';
import 'package:kana_plus_plus/src/data/repositories/word.repository.dart';
import 'package:kana_plus_plus/src/domain/entities/kana.entity.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/domain/entities/translate.entity.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/exception/not_found.exception.dart';
import 'package:kana_plus_plus/src/domain/usecases/words.controller.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  final wordRepository = WordRepositoryMock();
  final controller = WordsController(wordRepository: wordRepository);

  group('show word detail', () {
    test('must return a full word to show in word detail', () {
      const int wordId = 0;
      when(() => wordRepository.getWord(wordId))
          .thenAnswer((_) => Future.value(wordSample1));

      final wordResult = controller.showWordDetail(wordId);

      verify(() => wordRepository.getWord(wordId)).called(1);
      expect(wordResult, completion(equals(wordSample1)));
    });

    test('must throw not found exception when the database don't find word',
        () {
      const int wordId = -1;
      when(() => wordRepository.getWord(wordId)).thenThrow(NotFoundException());

      expect(() => controller.showWordDetail(wordId),
          throwsA(isA<NotFoundException>()));
      verify(() => wordRepository.getWord(wordId)).called(1);
    });
  });

  group('set to load all words', () {
    test('must return all words when the first call', () {
      when(() => wordRepository.getWords())
          .thenAnswer((invocation) => Future.value(wordsSample0));
      when(() => wordRepository.getWordsById(0))
          .thenAnswer((invocation) => Future.value(wordsSample1));
      when(() => wordRepository.getWordsByQuery(''))
          .thenAnswer((invocation) => Future.value(wordsSample2));

      final wordsResult = controller.showWords();

      verify(() => wordRepository.getWords()).called(1);
      verifyNever(() => wordRepository.getWordsById(0));
      verifyNever(() => wordRepository.getWordsByQuery(''));
      expect(wordsResult, completion(wordsSample0));
    });

    test('must return all words when setToLoadAllWords is called before', () {
      when(() => wordRepository.getWords())
          .thenAnswer((invocation) => Future.value(wordsSample0));
      when(() => wordRepository.getWordsById(0))
          .thenAnswer((invocation) => Future.value(wordsSample1));
      when(() => wordRepository.getWordsByQuery(''))
          .thenAnswer((invocation) => Future.value(wordsSample2));

      controller.setToLoadAllWords();
      final wordsResult = controller.showWords();

      verify(() => wordRepository.getWords()).called(1);
      verifyNever(() => wordRepository.getWordsById(0));
      verifyNever(() => wordRepository.getWordsByQuery(''));
      expect(wordsResult, completion(wordsSample0));
    });

    test('must throw no exception when didn't return any word', () {
      when(() => wordRepository.getWords()).thenThrow(NotFoundException());

      controller.setToLoadAllWords();

      expect(() => controller.showWords(), throwsA(isA<NotFoundException>()));
      verify(() => wordRepository.getWords()).called(1);
    });
  });

  group('set to load words by id', () {
    test(
        'must return words by id when setToLoadWordsById is called before with word id',
        () {
      when(() => wordRepository.getWords())
          .thenAnswer((invocation) => Future.value(wordsSample0));
      when(() => wordRepository.getWordsById(0))
          .thenAnswer((invocation) => Future.value(wordsSample1));
      when(() => wordRepository.getWordsByQuery(''))
          .thenAnswer((invocation) => Future.value(wordsSample2));

      controller.setToLoadWordsById(0);
      final wordsResult = controller.showWords();

      verifyNever(() => wordRepository.getWords());
      verify(() => wordRepository.getWordsById(0)).called(1);
      verifyNever(() => wordRepository.getWordsByQuery(''));
      expect(wordsResult, completion(wordsSample1));
    });

    test('must throw no exception when didn't find any word', () {
      when(() => wordRepository.getWordsById(0)).thenThrow(NotFoundException());

      controller.setToLoadWordsById(0);

      expect(() => controller.showWords(), throwsA(isA<NotFoundException>()));
      verify(() => wordRepository.getWordsById(0)).called(1);
    });
  });

  group('set to load words by query', () {
    test(
        'must return words by query when setToLoadWordsByQuery is called before with query',
        () {
      when(() => wordRepository.getWords())
          .thenAnswer((invocation) => Future.value(wordsSample0));
      when(() => wordRepository.getWordsById(0))
          .thenAnswer((invocation) => Future.value(wordsSample1));
      when(() => wordRepository.getWordsByQuery(''))
          .thenAnswer((invocation) => Future.value(wordsSample2));

      controller.setToLoadWordsByQuery('');
      final wordsResult = controller.showWords();

      verifyNever(() => wordRepository.getWords());
      verifyNever(() => wordRepository.getWordsById(0));
      verify(() => wordRepository.getWordsByQuery('')).called(1);
      expect(wordsResult, completion(wordsSample2));
    });

    test('must throw no exception when didn't find any word', () {
      when(() => wordRepository.getWordsByQuery(''))
          .thenThrow(NotFoundException());

      controller.setToLoadWordsByQuery('');

      expect(() => controller.showWords(), throwsA(isA<NotFoundException>()));
      verify(() => wordRepository.getWordsByQuery('')).called(1);
    });
  });
}

class WordRepositoryMock extends Mock implements WordRepository {}

const List<Word> wordsSample0 = [
  wordSample0,
  wordSample1,
  wordSample2,
  wordSample3,
  wordSample4,
  wordSample5,
];

const List<Word> wordsSample1 = [
  wordSample0,
];

const List<Word> wordsSample2 = [
  wordSample0,
  wordSample1,
  wordSample2,
];

const Word wordSample0 = Word(
  id: 0,
  text: 'ねこ',
  romaji: 'neko',
  imageUrl: 'lib/assets/images/words/cat.png',
  translate: Translate(id: 0, code: 'en', translate: 'cat'),
  kanas: [
    Kana(
        id: 23,
        text: 'ね',
        imageUrl: 'lib/assets/images/hiragana/ne.png',
        type: KanaType.hiragana),
    Kana(
        id: 9,
        text: 'こ',
        imageUrl: 'lib/assets/images/hiragana/ko.png',
        type: KanaType.hiragana),
  ],
);
const Word wordSample1 = Word(
  id: 1,
  text: 'いぬ',
  romaji: 'inu',
  imageUrl: 'lib/assets/images/words/dog.png',
  translate: Translate(id: 0, code: 'en', translate: 'dog'),
  kanas: [
    Kana(
        id: 1,
        text: 'い',
        imageUrl: 'lib/assets/images/hiragana/i.png',
        type: KanaType.hiragana),
    Kana(
        id: 22,
        text: 'ぬ',
        imageUrl: 'lib/assets/images/hiragana/nu.png',
        type: KanaType.hiragana),
  ],
);
const Word wordSample2 = Word(
  id: 2,
  text: 'とり',
  romaji: 'tori',
  imageUrl: 'lib/assets/images/words/bird.png',
  translate: Translate(id: 0, code: 'en', translate: 'bird'),
  kanas: [
    Kana(
        id: 19,
        text: 'と',
        imageUrl: 'lib/assets/images/hiragana/to.png',
        type: KanaType.hiragana),
    Kana(
        id: 39,
        text: 'り',
        imageUrl: 'lib/assets/images/hiragana/ri.png',
        type: KanaType.hiragana),
  ],
);
const Word wordSample3 = Word(
  id: 3,
  text: 'うさぎ',
  romaji: 'usagi',
  imageUrl: 'lib/assets/images/words/rabbit.png',
  translate: Translate(id: 0, code: 'en', translate: 'rabbit'),
  kanas: [
    Kana(
        id: 2,
        text: 'う',
        imageUrl: 'lib/assets/images/hiragana/u.png',
        type: KanaType.hiragana),
    Kana(
        id: 10,
        text: 'さ',
        imageUrl: 'lib/assets/images/hiragana/sa.png',
        type: KanaType.hiragana),
    Kana(
        id: 47,
        text: 'ぎ',
        imageUrl: 'lib/assets/images/hiragana/gi.png',
        type: KanaType.hiragana),
  ],
);
const Word wordSample4 = Word(
  id: 4,
  text: 'うし',
  romaji: 'ushi',
  imageUrl: 'lib/assets/images/words/cow.png',
  translate: Translate(id: 0, code: 'en', translate: 'cow'),
  kanas: [
    Kana(
        id: 2,
        text: 'う',
        imageUrl: 'lib/assets/images/hiragana/u.png',
        type: KanaType.hiragana),
    Kana(
        id: 11,
        text: 'し',
        imageUrl: 'lib/assets/images/hiragana/si.png',
        type: KanaType.hiragana),
  ],
);
const Word wordSample5 = Word(
  id: 5,
  text: 'うま',
  romaji: 'uma',
  imageUrl: 'lib/assets/images/words/horse.png',
  translate: Translate(id: 0, code: 'en', translate: 'horse'),
  kanas: [
    Kana(
        id: 2,
        text: 'う',
        imageUrl: 'lib/assets/images/hiragana/u.png',
        type: KanaType.hiragana),
    Kana(
        id: 30,
        text: 'ま',
        imageUrl: 'lib/assets/images/hiragana/ma.png',
        type: KanaType.hiragana),
  ],
);
