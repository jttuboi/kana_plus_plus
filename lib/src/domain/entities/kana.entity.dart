class Kana {
  const Kana({
    required this.id,
    required this.kana,
    required this.imageUrl,
    this.romaji = "",
    // TODO precisa trocar o vazio por uma imagem vazia
    this.romajiImageUrl = "",
  });

  const Kana.empty()
      : id = -1,
        kana = "",
        // TODO precisa trocar o vazio por uma imagem vazia
        imageUrl = "",
        romaji = "",
        // TODO precisa trocar o vazio por uma imagem vazia
        romajiImageUrl = "";

  final int id;
  final String kana;
  final String imageUrl;
  final String romaji;
  final String romajiImageUrl;
}
