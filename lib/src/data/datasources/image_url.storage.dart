class ImageUrl {
  ImageUrl._();

  // TODO remover image test folder quando deploy e adicionar as imagens prontas na pasta certa
  static const imageTestFolder = 'lib/assets/tests/images/';
  static const imageFolder = 'lib/assets/images/';

  static const empty = '${imageTestFolder}empty.svg';

  static const introWriting = '${imageFolder}menu/introduction/writing.svg';
  static const introVocabulary = '${imageFolder}menu/introduction/vocabulary.svg';
  static const introStudy = '${imageFolder}menu/introduction/study.svg';
  static const introTraining = '${imageFolder}menu/introduction/training.svg';
  static const introRecommendation = '${imageFolder}menu/introduction/recommendation.svg';

  static final List<String> menuKanas = [
    '${imageFolder}menu/kanas/あ.svg',
    '${imageFolder}menu/kanas/ア.svg',
    '${imageFolder}menu/kanas/い.svg',
    '${imageFolder}menu/kanas/イ.svg',
    '${imageFolder}menu/kanas/う.svg',
    '${imageFolder}menu/kanas/ウ.svg',
    '${imageFolder}menu/kanas/え.svg',
    '${imageFolder}menu/kanas/エ.svg',
    '${imageFolder}menu/kanas/お.svg',
    '${imageFolder}menu/kanas/オ.svg',
  ];
}
