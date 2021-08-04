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
  final _repository = WordRepositoryMock();
  final controller = WordsController(wordRepository: _repository);

  group("show word detail", () {
    test("must return a full word to show in word detail", () {
      const int wordId = 0;
      when(() => _repository.getWord(wordId))
          .thenAnswer((_) => Future.value(wordSample1));

      final wordResult = controller.showWordDetail(wordId);

      verify(() => _repository.getWord(wordId)).called(1);
      expect(wordResult, completion(equals(wordSample1)));
    });

    test("must throw not found exception when the database don't find word",
        () {
      const int wordId = -1;
      when(() => _repository.getWord(wordId)).thenThrow(NotFoundException());

      expect(() => controller.showWordDetail(wordId),
          throwsA(isA<NotFoundException>()));
      verify(() => _repository.getWord(wordId)).called(1);
    });
  });

  group("set to load all words", () {
    test("must return all words when the first call", () {
      when(() => _repository.getWords())
          .thenAnswer((invocation) => Future.value(wordsSample0));
      when(() => _repository.getWordsById(0))
          .thenAnswer((invocation) => Future.value(wordsSample1));
      when(() => _repository.getWordsByQuery(""))
          .thenAnswer((invocation) => Future.value(wordsSample2));

      final wordsResult = controller.showWords();

      verify(() => _repository.getWords()).called(1);
      verifyNever(() => _repository.getWordsById(0));
      verifyNever(() => _repository.getWordsByQuery(""));
      expect(wordsResult, completion(wordsSample0));
    });

    test("must return all words when setToLoadAllWords is called before", () {
      when(() => _repository.getWords())
          .thenAnswer((invocation) => Future.value(wordsSample0));
      when(() => _repository.getWordsById(0))
          .thenAnswer((invocation) => Future.value(wordsSample1));
      when(() => _repository.getWordsByQuery(""))
          .thenAnswer((invocation) => Future.value(wordsSample2));

      controller.setToLoadAllWords();
      final wordsResult = controller.showWords();

      verify(() => _repository.getWords()).called(1);
      verifyNever(() => _repository.getWordsById(0));
      verifyNever(() => _repository.getWordsByQuery(""));
      expect(wordsResult, completion(wordsSample0));
    });

    test("must throw no exception when didn't return any word", () {
      when(() => _repository.getWords()).thenThrow(NotFoundException());

      controller.setToLoadAllWords();

      expect(() => controller.showWords(), throwsA(isA<NotFoundException>()));
      verify(() => _repository.getWords()).called(1);
    });
  });

  group("set to load words by id", () {
    test(
        "must return words by id when setToLoadWordsById is called before with word id",
        () {
      when(() => _repository.getWords())
          .thenAnswer((invocation) => Future.value(wordsSample0));
      when(() => _repository.getWordsById(0))
          .thenAnswer((invocation) => Future.value(wordsSample1));
      when(() => _repository.getWordsByQuery(""))
          .thenAnswer((invocation) => Future.value(wordsSample2));

      controller.setToLoadWordsById(0);
      final wordsResult = controller.showWords();

      verifyNever(() => _repository.getWords());
      verify(() => _repository.getWordsById(0)).called(1);
      verifyNever(() => _repository.getWordsByQuery(""));
      expect(wordsResult, completion(wordsSample1));
    });

    test("must throw no exception when didn't find any word", () {
      when(() => _repository.getWordsById(0)).thenThrow(NotFoundException());

      controller.setToLoadWordsById(0);

      expect(() => controller.showWords(), throwsA(isA<NotFoundException>()));
      verify(() => _repository.getWordsById(0)).called(1);
    });
  });

  group("set to load words by query", () {
    test(
        "must return words by query when setToLoadWordsByQuery is called before with query",
        () {
      when(() => _repository.getWords())
          .thenAnswer((invocation) => Future.value(wordsSample0));
      when(() => _repository.getWordsById(0))
          .thenAnswer((invocation) => Future.value(wordsSample1));
      when(() => _repository.getWordsByQuery(""))
          .thenAnswer((invocation) => Future.value(wordsSample2));

      controller.setToLoadWordsByQuery("");
      final wordsResult = controller.showWords();

      verifyNever(() => _repository.getWords());
      verifyNever(() => _repository.getWordsById(0));
      verify(() => _repository.getWordsByQuery("")).called(1);
      expect(wordsResult, completion(wordsSample2));
    });

    test("must throw no exception when didn't find any word", () {
      when(() => _repository.getWordsByQuery(""))
          .thenThrow(NotFoundException());

      controller.setToLoadWordsByQuery("");

      expect(() => controller.showWords(), throwsA(isA<NotFoundException>()));
      verify(() => _repository.getWordsByQuery("")).called(1);
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
  word: "ねこ",
  romaji: "neko",
  imageUrl: "lib/assets/images/words/cat.png",
  translate: Translate(id: 0, code: "en", translate: "cat"),
  kanas: [
    Kana(
        id: 23,
        kana: "ね",
        imageUrl: "lib/assets/images/hiragana/ne.png",
        type: KanaType.hiragana),
    Kana(
        id: 9,
        kana: "こ",
        imageUrl: "lib/assets/images/hiragana/ko.png",
        type: KanaType.hiragana),
  ],
);
const Word wordSample1 = Word(
  id: 1,
  word: "いぬ",
  romaji: "inu",
  imageUrl: "lib/assets/images/words/dog.png",
  translate: Translate(id: 0, code: "en", translate: "dog"),
  kanas: [
    Kana(
        id: 1,
        kana: "い",
        imageUrl: "lib/assets/images/hiragana/i.png",
        type: KanaType.hiragana),
    Kana(
        id: 22,
        kana: "ぬ",
        imageUrl: "lib/assets/images/hiragana/nu.png",
        type: KanaType.hiragana),
  ],
);
const Word wordSample2 = Word(
  id: 2,
  word: "とり",
  romaji: "tori",
  imageUrl: "lib/assets/images/words/bird.png",
  translate: Translate(id: 0, code: "en", translate: "bird"),
  kanas: [
    Kana(
        id: 19,
        kana: "と",
        imageUrl: "lib/assets/images/hiragana/to.png",
        type: KanaType.hiragana),
    Kana(
        id: 39,
        kana: "り",
        imageUrl: "lib/assets/images/hiragana/ri.png",
        type: KanaType.hiragana),
  ],
);
const Word wordSample3 = Word(
  id: 3,
  word: "うさぎ",
  romaji: "usagi",
  imageUrl: "lib/assets/images/words/rabbit.png",
  translate: Translate(id: 0, code: "en", translate: "rabbit"),
  kanas: [
    Kana(
        id: 2,
        kana: "う",
        imageUrl: "lib/assets/images/hiragana/u.png",
        type: KanaType.hiragana),
    Kana(
        id: 10,
        kana: "さ",
        imageUrl: "lib/assets/images/hiragana/sa.png",
        type: KanaType.hiragana),
    Kana(
        id: 47,
        kana: "ぎ",
        imageUrl: "lib/assets/images/hiragana/gi.png",
        type: KanaType.hiragana),
  ],
);
const Word wordSample4 = Word(
  id: 4,
  word: "うし",
  romaji: "ushi",
  imageUrl: "lib/assets/images/words/cow.png",
  translate: Translate(id: 0, code: "en", translate: "cow"),
  kanas: [
    Kana(
        id: 2,
        kana: "う",
        imageUrl: "lib/assets/images/hiragana/u.png",
        type: KanaType.hiragana),
    Kana(
        id: 11,
        kana: "し",
        imageUrl: "lib/assets/images/hiragana/si.png",
        type: KanaType.hiragana),
  ],
);
const Word wordSample5 = Word(
  id: 5,
  word: "うま",
  romaji: "uma",
  imageUrl: "lib/assets/images/words/horse.png",
  translate: Translate(id: 0, code: "en", translate: "horse"),
  kanas: [
    Kana(
        id: 2,
        kana: "う",
        imageUrl: "lib/assets/images/hiragana/u.png",
        type: KanaType.hiragana),
    Kana(
        id: 30,
        kana: "ま",
        imageUrl: "lib/assets/images/hiragana/ma.png",
        type: KanaType.hiragana),
  ],
);
