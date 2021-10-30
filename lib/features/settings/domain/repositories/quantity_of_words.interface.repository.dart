abstract class IQuantityOfWordsRepository {
  Future<int> getQuantityOfWords();

  Future<void> updateQuantityOfWords(int quantityOfWords);
}
