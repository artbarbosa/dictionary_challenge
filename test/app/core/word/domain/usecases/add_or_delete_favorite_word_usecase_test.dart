import 'package:dictionary/app/core/shared/errors/failures.dart';
import 'package:dictionary/app/core/word/domain/repositories/favorite_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/repositories/word_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/usecases/add_or_delete_favorite_word_usecase.dart';
import 'package:dictionary/app/core/word/infra/models/word.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mock.dart';

void main() {
  late AddOrDeleteFavoriteWordUseCase usecase;
  late IFavoriteRepository favoriteRepository;
  late IWordRepository wordRepository;

  setUpAll(() async {
    wordRepository = IWordRepositoryMock();
    favoriteRepository = IFavoriteRepositoryMock();
    usecase = AddOrDeleteFavoriteWordUseCase(
      wordRepository: wordRepository,
      favoriteRepository: favoriteRepository,
    );
  });

  test(
      "Should check if you received the data from getLocalWordInfo and save as a favorite",
      () {
    const word = "mock";
    const favoriteState = true;
    final wordModelMock = WordModel(
      word: word,
      definitions: {},
      pronunciation: "pronunciation",
      orderWord: null,
    );

    when(() => wordRepository.getLocalWordInfo(any()))
        .thenAnswer((_) async => wordModelMock);

    when(() => wordRepository.saveWordInfo(any(), any()))
        .thenAnswer((_) => Future(() => null));

    usecase.call(word: word, favoriteState: favoriteState);

    verify(() => wordRepository.getLocalWordInfo(word)).called(1);
    verifyNever(() => wordRepository.getWordInfo(word)).called(0);
  });

  test(
      "Should check if you received the data from getWordInfo and save as a favorite",
      () {
    const word = "mock";
    const favoriteState = true;
    final wordModelMock = WordModel(
      word: word,
      definitions: {},
      pronunciation: "pronunciation",
      orderWord: null,
    );
    when(() => wordRepository.getLocalWordInfo(any()))
        .thenAnswer((_) async => Future(() => null));
    when(() => wordRepository.getWordInfo(any()))
        .thenAnswer((_) async => Future(() => wordModelMock));
    when(() => wordRepository.saveWordInfo(any(), any()))
        .thenAnswer((_) => Future(() => null));

    usecase.call(word: word, favoriteState: favoriteState);

    verify(() => wordRepository.getLocalWordInfo(word)).called(1);
  });

  test("Should throw error argument is empty", () async {
    const word = "";
    const favoriteState = true;
    final wordModelMock = WordModel(
      word: word,
      definitions: {},
      pronunciation: "pronunciation",
      orderWord: null,
    );
    when(() => wordRepository.getLocalWordInfo(any()))
        .thenAnswer((_) async => Future(() => null));
    when(() => wordRepository.getWordInfo(any()))
        .thenAnswer((_) async => Future(() => wordModelMock));
    when(() => wordRepository.saveWordInfo(any(), any()))
        .thenAnswer((_) => Future(() => null));

    expect(
        () async =>
            await usecase.call(word: word, favoriteState: favoriteState),
        throwsA(isA<ArgumentFailure>()));
  });

  test("Should throw error ApiFailure", () async {
    const word = "mock";
    const favoriteState = true;

    when(() => wordRepository.getLocalWordInfo(any()))
        .thenAnswer((_) async => Future(() => null));
    when(() => wordRepository.getWordInfo(any()))
        .thenThrow(ApiFailure(message: "", code: 404));
    when(() => wordRepository.saveWordInfo(any(), any()))
        .thenAnswer((_) => Future(() => null));

    expect(
        () async =>
            await usecase.call(word: word, favoriteState: favoriteState),
        throwsA(isA<ApiFailure>()));
  });

  test("Should throw error GenericFailure", () async {
    const word = "mock";
    const favoriteState = true;

    when(() => wordRepository.getLocalWordInfo(any()))
        .thenAnswer((_) async => Future(() => null));
    when(() => wordRepository.getWordInfo(any()))
        .thenThrow(GenericFailure(message: ""));
    when(() => wordRepository.saveWordInfo(any(), any()))
        .thenAnswer((_) => Future(() => null));

    expect(
        () async =>
            await usecase.call(word: word, favoriteState: favoriteState),
        throwsA(isA<GenericFailure>()));
  });
}
