import 'package:dictionary/app/core/shared/errors/failures.dart';
import 'package:dictionary/app/core/word/domain/usecases/get_word_info_usercase.dart';
import 'package:dictionary/app/core/word/infra/models/word.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mock.dart';

void main() {
  late IGetWordInfoUseCase usecase;
  late IWordRepositoryMock wordRepository;

  setUpAll(() async {
    wordRepository = IWordRepositoryMock();
    usecase = GetWordInfoUseCase(
      repository: wordRepository,
    );
  });

  test("Should check if you received the data from getLocalWordInfo", () {
    const word = "mock";
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

    usecase.call(word: word);

    verify(() => wordRepository.getLocalWordInfo(word)).called(1);
    verifyNever(() => wordRepository.getWordInfo(word)).called(0);
  });

  test("Should check if you received the data from getWordInfo", () {
    const word = "mock";
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

    usecase.call(word: word);

    verify(() => wordRepository.getLocalWordInfo(word)).called(1);
  });

  test("Should throw error argument is empty", () async {
    const word = "";
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

    expect(() async => await usecase.call(word: word),
        throwsA(isA<ArgumentFailure>()));
  });

  test("Should throw error ApiFailure", () async {
    const word = "mock";

    when(() => wordRepository.getLocalWordInfo(any()))
        .thenAnswer((_) async => Future(() => null));
    when(() => wordRepository.getWordInfo(any()))
        .thenThrow(ApiFailure(message: "", code: 404));
    when(() => wordRepository.saveWordInfo(any(), any()))
        .thenAnswer((_) => Future(() => null));

    expect(
        () async => await usecase.call(word: word), throwsA(isA<ApiFailure>()));
  });

  test("Should throw error GenericFailure", () async {
    const word = "mock";

    when(() => wordRepository.getLocalWordInfo(any()))
        .thenAnswer((_) async => Future(() => null));
    when(() => wordRepository.getWordInfo(any()))
        .thenThrow(GenericFailure(message: ""));
    when(() => wordRepository.saveWordInfo(any(), any()))
        .thenAnswer((_) => Future(() => null));

    expect(() async => await usecase.call(word: word),
        throwsA(isA<GenericFailure>()));
  });
}
