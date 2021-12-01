# KWriting

## Sobre o app

O app tem a função de ensinar iniciantes a aprender os alfabetos Hiragana e Katakana através da escrita. Para isso foi utilizado uma técnica em que utiliza as palavras (em geral, nomes de coisas) para aprender a escrever em Japonês.

O uso de imagens das coisas também foi utilizado para associar o que o usuário está escrevendo em Japonês diretamente a representação visual, assim evitando associar diretamente a palavra traduzida. Por isso palavras como adjetivos, ações, verbos não são utilizados, pois são mais difíceis de representar visualmente por uma imagem estática.

Como extra, o aprendiz ganha um vocabulário inicial.

Para mais informações, acesse o app na Play Store.
https://play.google.com/store/apps/details?id=com.kana_plus_plus

<img src="/github/Screenshot_1.png" width="270" height="570" />
<img src="/github/Screenshot_2.png" width="270" height="570" />
<img src="/github/Screenshot_3.png" width="270" height="570" />
<img src="/github/Screenshot_4.png" width="270" height="570" />
<img src="/github/Screenshot_5.png" width="270" height="570" />

### Troca de nome

O projeto originalmente chamava Kana++, mas devido à política para desenvolvedor da Play Store, caracteres especiais repetidos não são aceitos. Sendo assim, o app se chama KWriting. <i>Sem momento criatividade ao criar esse nome =(.</i>

## Sobre o projeto

Este app foi construído com intuito de aplicar as técnicas aprendidas sobre Flutter e também sobre arquitetura de software. Além disso o aplicativo foi enviado para Play Store com intuito de aprender todo processo desde a criação da ideia até o envio do app na Play Store.

O projeto foi construído com Flutter 2.5.2 e Dart 2.14.3 com foco em Android (não foi implementado para iOS, mas está pré-preparado para incluir códigos para fazer deploy para iOS).

Para construção do app, foi utilizado o VSCode, Inkscape (imagens) e python (manipulação automática dos dados do .svg para geração de pontos).

Caso queira seguir as próximas etapas do projeto, acesse o Trello: https://trello.com/b/EVoHrCbF

## Entendendo a arquitetura do projeto

### atualizando

## Instruções extras

### Execução do projeto

Faça o git clone ou baixe o projeto.

Após pegar o projeto, entre na pasta do projeto pelo terminal e digite `flutter pub get` para pegar os pacotes e atualizar o projeto.

Não esqueça de mudar o conteúdo `android:value="ca-app-pub-xxxxxxxxxxxxxxxx~yyyyyyyyyy"` no arquivo `android/app/src/main/AndroidManifest.xml`.
Senão mudar, o projeto não irá fazer o deploy no celular/emulador.
Esse valor é o app ID gerado no site do adMob. Para mais informações, entre em:
https://flutter.dev/ads
https://pub.dev/packages/google_mobile_ads

Em seguida utilize o comando `flutter build apk` para gerar o apk.

Recomendo utilizar o VSCode ou Android Studio para executar o projeto. Com algum deles fica mais fácil criar os emuladores de Android ou ter acesso ao DevTools para melhor debug.

Dentro do arquivo `.vscode/launch.json` contém alguns modos de execução. Ler https://flutter.dev/docs/development/tools/vs-code#run-app-in-debug-profile-or-release-mode.

### Atualizar o ícone do app

Para atualizar o ícone do app é utilizado o package [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons).

#### Android

Primeiro precisa criar 3 pngs:
- `assets/icons/app_icon_background.png`
- `assets/icons/app_icon_foreground.png`
- `assets/icons/app_icon.png`

Após isso, executar no terminal:
```sh
flutter pub run flutter_launcher_icons:main
```

O package irá gerar automaticamente as imagens necessárias dentro da pasta do android.

Mais informações em: [Android Adaptive Icon](https://developer.android.com/guide/practices/ui_guidelines/icon_design_adaptive)

Extra: se quiser modificar o splash screen que é mostrado ao abrir o app, modificar o arquivo `android/app/src/main/res/drawable/launch_background.xml`.

Mais informações em: [Splash Screen Flutter](https://flutter.dev/docs/development/ui/advanced/splash-screen)

#### iOS

Para atualizar o app icon para o iOS, precisa descomentar no `pubspec.yaml` a linha `ios: true`.

Obs: Ler em [Note](https://pub.dev/packages/flutter_launcher_icons#mag-attributes) para ver como aplicar o design para app icon no iOS.

Após isso, executar no terminal:
```sh
flutter pub run flutter_launcher_icons:main
```

## Licença

##### Licença copiado do termos de uso

The software is open source. Its code is shared at https://github.com/jttuboi/kana_plus_plus. All content specifically available in the repository can be used under the MIT License.

The images used as the images of the words and the images of the hiraganas and katakanas are my property. They are not allowed to be used, modified or shared in other projects without my permission. That's why it's not even shared in the project.

The image strokes of the hiragana and katakana syllables were taken from [KanjiVG](http://kanjivg.tagaini.net/) and these images are on [Creative Commons Attribution-Share Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

The syllable points were taken from the SVG images of [KanjiVG](http://kanjivg.tagaini.net/) and these images are over [Creative Commons Attribution-Share Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

The overview information is taken from Wikipedia [Hiragana en](https://en.wikipedia.org/wiki/Hiragana), [Hiragana pt](https://pt.wikipedia.org/wiki/Hiragana) [Katakana en](https://en.wikipedia.org/wiki/Katakana), [Katakana pt](https://pt.wikipedia.org/wiki/Katakana).

The licenses for the fonts used are mentioned within the project and can be seen at https://github.com/jttuboi/kana_plus_plus/tree/master/assets/fonts.

The icons were taken from [Google fonts](https://fonts.google.com/icons) and those non-existent icons were created by me and can be seen at https://github.com/jttuboi/kana_plus_plus/tree/master/assets/icons.

The word data information were mostly collected through [Jisho](https://jisho.org/).

##### termos de uso e política de privacidade do app

https://tuboi-studios.github.io/kwriting_terms_of_use_and_privacy_policy/
