# kana_plus_plus



### Instruções

#### atualizar o ícone do app
Para atualizar o ícone do app, executar no terminal:
```sh
flutter pub run flutter_launcher_icons:main
```
O arquivo é `lib/assets/icons/app_icon.png`

> [Flutter Laucher Icons][https://pub.dev/packages/flutter_launcher_icons]

### Entendendo a arquitetura do projeto

#### presentation
Contém a parte visual do projeto. É o único local que deve ter acesso as bibliotecas do Flutter.

##### arguments
São classes que servem para guardar os dados que são transmitidos de uma página para outra caso a seguinte necessite de dados da anterior.

##### pages
São classes que representam as páginas da tela. Nessas terão as páginas específicas para android e páginas específicas para ios.

##### state_management
São páginas que controlam o estado das páginas. Eles armazenam os dados temporários caso necessite e também são os que conectam com os casos de uso.

##### utils
São classes que contém os dados para utilizar em qualquer parte da interface.
Nele que está o routes.dart, cujo contém constantes para rotas de cada página.

##### widgets
São componentes (em flutter é widgets) que servem para modularizar a parte visual, podendo ser reaproveitados entre as páginas.

#### domain
Contém a parte das regras de negócio do projeto. É a parte em que é obrigatório a implementação de testes.

##### core
São classes que contém os dados relacionados a todo sistema, por exemplo dados de configurações.

##### entities
São classes que representam os dados do sistema. Também contém os enums que representam os elementos de uma variável.

##### repositories
São interfaces que retornam os dados do sistema. Não necessita o conhecimento de como é guardado os dados, apenas sabe quais dados são retornados.

##### services
São interfaces que retornam os dados relacionados a parte externa em relação ao sistema.

##### usecases
São classes que representam as regras de negócio do sistema.

#### data
Contém a parte do acesso aos dados. Além de ter a estrutura para armazenar e dar os dados para a camada domain, ela contém estrutura para acessar estruturas fora do sistema.

##### datasources
São classes que implementam qual são os tipos de acessos aos dados internos do sistema, por exemplo, acessa via sqlite ou acessa por shared preferences.

###### interfaces
São interfaces que permitem os repositórios acessar os dados sem precisar conhecer o conteúdo de que base está vindo.

##### models
São classes que extendem das entities que contém informações de como devem ser os dados. Nele que tem o tratamento e conversões de dados.

##### repositories
São as implementações das interfaces dos repositórios do domain. Neles são refatorados os dados e encaminhados para o local próprio.

##### services
São as implementações das interfaces dos services do domain. Neles são refatorados os dados e encaminhados para o local de acesso a esses dados.

##### utils
São classes que contém os dados para utilizar em qualquer parte do domain como nomes das tabelas, colunas da database e os nomes para o acesso dos dados das preferências.
