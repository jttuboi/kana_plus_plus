// // ignore_for_file: unnecessary_lambdas

// import 'package:flutter_test/flutter_test.dart';
// import 'package:kwriting/core/core.dart';
// import 'package:kwriting/features/training/training.dart';
// import 'package:kwriting/features/words/words.dart';
// import 'package:mocktail/mocktail.dart';

// void main() {
//   final wordRepository = WordRepositoryMock();
//   final controller = WordsController(wordRepository: wordRepository);

//   group('show word detail', () {
//     test('must return a full word to show in word detail', () {
//       const wordId = 'ねこ';
//       when(() => wordRepository.getWord(wordId)).thenAnswer((_) => wordSample0);

//       final wordResult = controller.wordDetail(wordId);

//       verify(() => wordRepository.getWord(wordId)).called(1);
//       expect(wordResult, equals(wordSample0));
//       expect(wordResult.id, equals('ねこ'));
//       expect(wordResult.type, equals(KanaType.hiragana));
//       expect(wordResult.romaji, equals('neko'));
//       expect(wordResult.imageUrl, equals('assets/images/words/cat.png'));
//       expect(wordResult.kanas.length, equals(2));
//       expect(wordResult.kanas[0].id, equals('ね'));
//       expect(wordResult.kanas[0].type, equals(KanaType.hiragana));
//       expect(wordResult.kanas[0].imageUrl, equals('assets/images/hiragana/ne.png'));
//       expect(wordResult.kanas[0].romaji, equals('ne'));
//       expect(wordResult.kanas[0].strokesQuantity, equals(2));
//       expect(wordResult.kanas[1].id, equals('こ'));
//       expect(wordResult.kanas[1].type, equals(KanaType.hiragana));
//       expect(wordResult.kanas[1].imageUrl, equals('assets/images/hiragana/ko.png'));
//       expect(wordResult.kanas[1].romaji, equals('ko'));
//       expect(wordResult.kanas[1].strokesQuantity, equals(2));
//     });
//   });

//   group('set to load all words', () {
//     test('must return all words when the first call', () {
//       when(() => wordRepository.getWords()).thenAnswer((invocation) => wordsSample0);
//       when(() => wordRepository.getWordsById('ねこ')).thenAnswer((invocation) => wordsSample1);
//       when(() => wordRepository.getWordsByQuery('')).thenAnswer((invocation) => wordsSample2);

//       final wordsResult = controller.wordsToShow;

//       verify(() => wordRepository.getWords()).called(1);
//       verifyNever(() => wordRepository.getWordsById('ねこ'));
//       verifyNever(() => wordRepository.getWordsByQuery(''));
//       expect(wordsResult, wordsSample0);
//     });

//     test('must return all words when setToLoadAllWords is called before', () {
//       when(() => wordRepository.getWords()).thenAnswer((invocation) => wordsSample0);
//       when(() => wordRepository.getWordsById('ねこ')).thenAnswer((invocation) => wordsSample1);
//       when(() => wordRepository.getWordsByQuery('')).thenAnswer((invocation) => wordsSample2);

//       controller.setToLoadAllWords();
//       final wordsResult = controller.wordsToShow;

//       verify(() => wordRepository.getWords()).called(1);
//       verifyNever(() => wordRepository.getWordsById('ねこ'));
//       verifyNever(() => wordRepository.getWordsByQuery(''));
//       expect(wordsResult, wordsSample0);
//     });
//   });

//   group('set to load words by id', () {
//     test('must return words by id when setToLoadWordsById is called before with word id', () {
//       when(() => wordRepository.getWords()).thenAnswer((invocation) => wordsSample0);
//       when(() => wordRepository.getWordsById('ねこ')).thenAnswer((invocation) => wordsSample1);
//       when(() => wordRepository.getWordsByQuery('')).thenAnswer((invocation) => wordsSample2);

//       controller.setToLoadWordsById('ねこ');
//       final wordsResult = controller.wordsToShow;

//       verifyNever(() => wordRepository.getWords());
//       verify(() => wordRepository.getWordsById('ねこ')).called(1);
//       verifyNever(() => wordRepository.getWordsByQuery(''));
//       expect(wordsResult, wordsSample1);
//     });
//   });

//   group('set to load words by query', () {
//     test('must return words by query when setToLoadWordsByQuery is called before with query', () {
//       when(() => wordRepository.getWords()).thenAnswer((invocation) => wordsSample0);
//       when(() => wordRepository.getWordsById('ねこ')).thenAnswer((invocation) => wordsSample1);
//       when(() => wordRepository.getWordsByQuery('')).thenAnswer((invocation) => wordsSample2);

//       controller.setToLoadWordsByQuery('');
//       final wordsResult = controller.wordsToShow;

//       verifyNever(() => wordRepository.getWords());
//       verifyNever(() => wordRepository.getWordsById('ねこ'));
//       verify(() => wordRepository.getWordsByQuery('')).called(1);
//       expect(wordsResult, wordsSample2);
//     });
//   });
// }

// class WordRepositoryMock extends Mock implements IWordRepository {}

// final wordsSample0 = [
//   wordSample0,
//   wordSample1,
//   wordSample2,
//   wordSample3,
//   wordSample4,
//   wordSample5,
// ];

// final wordsSample1 = [
//   wordSample0,
// ];

// final wordsSample2 = [
//   wordSample0,
//   wordSample1,
//   wordSample2,
// ];

// final wordSample0 = Word(
//   id: 'ねこ',
//   type: KanaType.hiragana,
//   romaji: 'neko',
//   imageUrl: 'assets/images/words/cat.png',
// )
//   ..setTranslate(const Translate(id: 'ねこ', english: 'cat', portuguese: 'gato', spanish: 'gato'))
//   ..kanas = [
//     const Kana(id: 'ね', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/ne.png', romaji: 'ne', strokesQuantity: 2),
//     const Kana(id: 'こ', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/ko.png', romaji: 'ko', strokesQuantity: 2),
//   ];

// final wordSample1 = Word(
//   id: 'いぬ',
//   type: KanaType.hiragana,
//   romaji: 'inu',
//   imageUrl: 'assets/images/words/dog.png',
// )
//   ..setTranslate(const Translate(id: 'いぬ', english: 'dog', portuguese: 'cachorro', spanish: 'perro'))
//   ..kanas = [
//     const Kana(id: 'い', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/i.png', romaji: 'i', strokesQuantity: 2),
//     const Kana(id: 'ぬ', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/nu.png', romaji: 'nu', strokesQuantity: 2),
//   ];

// final wordSample2 = Word(
//   id: 'とり',
//   type: KanaType.hiragana,
//   romaji: 'tori',
//   imageUrl: 'assets/images/words/bird.png',
// )
//   ..setTranslate(const Translate(id: 'とり', english: 'bird', portuguese: 'pássaro', spanish: 'pájaro'))
//   ..kanas = [
//     const Kana(id: 'と', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/to.png', romaji: 'to', strokesQuantity: 2),
//     const Kana(id: 'り', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/ri.png', romaji: 'ri', strokesQuantity: 2),
//   ];

// final wordSample3 = Word(
//   id: 'うさぎ',
//   type: KanaType.hiragana,
//   romaji: 'usagi',
//   imageUrl: 'assets/images/words/rabbit.png',
// )
//   ..setTranslate(const Translate(id: 'うさぎ', english: 'rabbit', portuguese: 'coelho', spanish: 'conejo'))
//   ..kanas = [
//     const Kana(id: 'う', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/u.png', romaji: 'u', strokesQuantity: 2),
//     const Kana(id: 'さ', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/sa.png', romaji: 'sa', strokesQuantity: 3),
//     const Kana(id: 'ぎ', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/gi.png', romaji: 'gi', strokesQuantity: 6),
//   ];

// final wordSample4 = Word(
//   id: 'うし',
//   type: KanaType.hiragana,
//   romaji: 'ushi',
//   imageUrl: 'assets/images/words/cow.png',
// )
//   ..setTranslate(const Translate(id: 'うし', english: 'cow', portuguese: 'vaca', spanish: 'vaca'))
//   ..kanas = [
//     const Kana(id: 'う', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/u.png', romaji: 'u', strokesQuantity: 2),
//     const Kana(id: 'し', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/shi.png', romaji: 'shi', strokesQuantity: 1),
//   ];

// final wordSample5 = Word(
//   id: 'うま',
//   type: KanaType.hiragana,
//   romaji: 'uma',
//   imageUrl: 'assets/images/words/horse.png',
// )
//   ..setTranslate(const Translate(id: 'うま', english: 'horse', portuguese: 'cavalo', spanish: 'caballo'))
//   ..kanas = [
//     const Kana(id: 'う', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/u.png', romaji: 'u', strokesQuantity: 2),
//     const Kana(id: 'ま', type: KanaType.hiragana, imageUrl: 'assets/images/hiragana/ma.png', romaji: 'ma', strokesQuantity: 3),
//   ];
