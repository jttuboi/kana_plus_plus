# KWriting

## Sobre o app

O app tem a função de ensinar iniciantes a aprender os alfabetos Hiragana e Katakana através da escrita. Para isso foi utilizado uma técnica em que utiliza as palavras (em geral de objetos) para aprender a escrever em Japonês.

O uso de imagens dos objetos também foi utilizado para associar a ela e evitar que o aprendiz associe a palavra em Japonês com o significado na sua língua materna, em outras palavras, evitar a tradução e focar na associação visual.

Como extra, o aprendiz ganha um vocabulário inicial.

Para mais informações, acesse o app na Play Store.
https://play.google.com/store/apps/details?id=com.kana_plus_plus

<img src="/github/Screenshot_1.png" width="270" height="570" />
<img src="/github/Screenshot_2.png" width="270" height="570" />
<img src="/github/Screenshot_3.png" width="270" height="570" />
<img src="/github/Screenshot_4.png" width="270" height="570" />
<img src="/github/Screenshot_5.png" width="270" height="570" />

## Sobre o projeto

Este app foi construído com intuito de aplicar as técnicas aprendidas sobre Flutter e também sobre arquitetura. Além disso o aplicativo foi enviado para Play Store com intuito de aprender todo processo desde a criação da ideia até o envio do app na Play Store.

O projeto foi construído com Flutter 2.5 e Dart 2.14.0 com foco em Android (não foi implementado para iOS, mas está pré preparado para incluir códigos para fazer deploy para iOS).

Para construção do app, foi utilizado o VSCode, Inkscape e python (manipulação automática dos dados do .svg para geração de pontos).

Caso queira seguir as próximas etapas do projeto, acesse o Trello.
https://trello.com/b/EVoHrCbF

## Entendendo a arquitetura do projeto

### presentation
Contém a parte visual do projeto. É o único local que deve ter acesso as bibliotecas do Flutter.

##### arguments
São classes que servem para guardar os dados que são transmitidos de uma página para outra caso a seguinte necessite de dados da anterior.

##### pages
São classes que representam as páginas da tela. Nessas terão as páginas específicas para android e páginas específicas para ios.

##### state_management
São páginas que controlam o estado de widgets específicos. Eles armazenam os dados temporários, caso necessite, tem acesso ao controller.

##### utils
São classes que contém os dados para utilizar em qualquer parte visual.
Nele que está o routes.dart, cujo contém constantes para rotas de cada página.
Também contém o consts.dart, cujo armazena os valores das cores, estilos, etc da parte visual.

##### widgets
São componentes (em flutter é widgets) que servem para modularizar a parte visual, podendo ser reaproveitados entre as páginas.

### domain
Contém a parte das regras de negócio do projeto. É obrigatório a implementação de testes.

##### controllers
São classes que representam as regras de negócio do sistema.

##### entities
São classes que representam os dados do sistema.

##### repositories
São interfaces que retornam os dados do sistema. Não necessita o conhecimento de como é guardado os dados, apenas sabe quais dados são retornados.

##### support
São classes que contém algoritmos específicos complexos.

##### utils
São classes que contém os dados relacionados a todo sistema, por exemplo dados de configurações.
Também contém os enums que representam os elementos de uma variável.

### data
Contém a parte do acesso aos dados. Além de ter a estrutura para armazenar e dar os dados para a camada domain, ela contém estrutura para acessar estruturas fora do sistema.

##### datasources
São classes que implementam qual são os tipos de acessos aos dados internos do sistema, por exemplo, acessa via sqlite ou acessa por shared preferences.

##### models
São classes que extendem das entities que contém informações de como devem ser os dados. Nele que tem o tratamento e conversões de dados.

##### repositories
São as implementações das interfaces dos repositórios do domain. Neles são refatorados os dados vindo do datasource.

##### singletons
São as classes com design pattern singleton que necessitam ser abertos apenas uma vez durante a abertura do app.

##### utils
São classes que contém os dados para utilizar em qualquer parte do domain como nomes das tabelas, colunas da database e os nomes para o acesso dos dados das preferências.

### test
São classes que contém os testes unitários dos controllers e do support.

## Instruções extras

### Execução do projeto

Faça o git clone ou baixe o projeto.

Após pegar o projeto, entre na pasta do projeto pelo terminal e digite `flutter pub get` para pegar os pacotes e atualizar o projeto.

Em seguida utilize o comando `flutter build apk` para gerar o apk.

Recomendo utilizar o VSCode ou Android Studio para executar o projeto. Com algum deles fica mais fácil criar os emuladores de Android ou ter acesso ao DevTools para melhor debug.

Dentro do arquivo `.vscode/launch.json` contém alguns modos de execução. Ler https://flutter.dev/docs/development/tools/vs-code#run-app-in-debug-profile-or-release-mode.

### Atualizar o ícone do app

Para atualizar o ícone do app é utilizado o package [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons).

#### Android

Primeiro precisa criar 3 pngs:
- `lib/assets/icons/app_icon_background.png`
- `lib/assets/icons/app_icon_foreground.png`
- `lib/assets/icons/app_icon.png`

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

The software is opensource. Its code is shared at https://github.com/jttuboi/kwriting. All content specifically available in the repository can be used under the MIT License.

The images used as the images of the words and the images of the hiraganas and katakanas are my property. They are not allowed to be used, modified or shared. That's why it's not even shared in the project at https://github.com/jttuboi/kwriting.

The image strokes of the hiragana and katakana syllables were taken from [KanjiVG](http://kanjivg.tagaini.net/) and these images are on [Creative Commons Attribution-Share Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

The syllable points were taken from the SVG images of [KanjiVG](http://kanjivg.tagaini.net/) and these images are over [Creative Commons Attribution-Share Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

The overview information is taken from Wikipedia [Hiragana en](https://en.wikipedia.org/wiki/Hiragana), [Hiragana pt](https://pt.wikipedia.org/wiki/Hiragana) [Katakana en](https://en.wikipedia.org/wiki/Katakana), [Katakana pt](https://pt.wikipedia.org/wiki/Katakana).

The licenses for the fonts used are mentioned within the project and can be seen at https://github.com/jttuboi/kwriting/tree/master/lib/assets/fonts.

The icons were taken from [Google fonts](https://fonts.google.com/icons) and those non-existent icons were created by me and can be seen at https://github.com/jttuboi/kwriting/tree/master/lib/assets/icons.

The word data were mostly collected through [Jisho](https://jisho.org/).

##### termos de uso e política de privacidade do app

https://tuboi-studios.github.io/kwriting_terms_of_use_and_privacy_policy/