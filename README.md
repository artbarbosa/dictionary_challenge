# Dictionary Challenge

## Layout
![record2](https://github.com/artbarbosa/pokedex_app_clean_architecture/assets/91624613/6a71d116-e140-453e-8896-4e8e68f0c069)

# Padrões do Projeto

## Flutter Version
A Versão do flutter que é utilizada neste projeto foi a 3.13.5.

## Apresentão geral da Arquitetura
O sistema foi dividido de forma modular, esses mesmo modulos podem conter submodules e cada modulo contém seu proprio sistema de arquitetura, cujo o utilizado neste projeto foi o Clean Dart.

![](https://user-images.githubusercontent.com/53379557/175559723-dafd93a1-2420-46c5-b1e7-ac814bcf4f2e.png)

## Segmented State Pattern

Utilizdo para permitir que um objeto altere seu comportamento quando seu estado interno mudar. O objeto aparecerá para alterar sua classe. Então é utlizado para pelos Controllers/Stores para modificar o estado das pages;

## Dependency inversion principle (DIP)

Pensando na manutenibilidade e desacoplamento, apliquei o princípio do DiP, um dos princípios do SOLID, onde as classes devem seguir uma interface (abstração) e serem uma implementação dessa interface e outras classes não devem depender da implementação e sim da interface.

## Service pattern

Utilize design pattern Service tanto para implementar as interfaces do HttpClient quanto isolar o package de database local

## Tratamento de Erros 

Como um dos aspectos mais importante durante o desenvolvimento de software, fiz o tratamento de error em suas respctivas camadas com classes criadas denominando possibilidades de erros e suas respctivas necessidades.

## Testes Unitários 

Para verificar o comportamento das unidades na aplicação e manter um desenvolvimento conciso e com maior quantidade de tratamento de erros e exceções apliquei testes unitários utilizando mocks para não criar dependência de dados externos.


# Como Utilizo o Projeto?

- Clone o projeto.
- Adquira duas credenciais para acesso ao WordsApi, acesse o site para instruções de como fazer.
- Na raiz do projeto crie um arquivo ".env" dentro da pasta "assets".
- Crie adicione sua credencia com o compo KEY dentro do ".env".
- Rode os comandos
  - `flutter pub get`
  - `dart run build_runner build --delete-conflicting-outputs`
  - `flutter run`


# Obrigatórios

- [x] Como usuário, devo ser capaz de visualizar uma lista de palavras com rolagem infinita
- [x] Como usuário, devo ser capaz de visualizar uma palavra, significados e a fonética
- [x] Como usuário, devo ser capaz de salvar a palavra como favorito
- [x] Como usuário, devo ser capaz de remover a palavra como favorito
- [x] Como usuário, devo ser capaz de visitar uma lista com as palavras que já vi anteriormente
- [x] A API não possui endpoint com a lista de palavras. Essa lista pode ser carregada em memória ou ser salva em banco de dados local ou remoto
- [x] Salvar em cache o resultado das requisições ao Words API, para agilizar a resposta em caso de buscas com parâmetros repetidos.
- [x] Seguir o wireframe para a página de listagem dos dados. Pode-se alterar a posição dos itens, mantendo as funcionalidades solicitadas.

  ![wireframe](https://github.com/artbarbosa/pokedex_app_clean_architecture/assets/91624613/3ca601d9-8cc2-4adb-b58a-81c1dbe7759a)

# [Diferenciais](#sobre)

- [x] Implementar um tocador de audio.
- [x] Utilizar alguma ferramenta de Injeção de Dependência.
- [x] Escrever Unit Tests ou E2E Test.

>  This is a challenge by [Coodesh](https://coodesh.com/)