abstract class IQuantityOfWordsRepository {
  int getQuantityOfWords2();

  void setQuantityOfWords(int value);

  Future<int> getQuantityOfWords();

  Future<void> updateQuantityOfWords(int quantityOfWords);
}
