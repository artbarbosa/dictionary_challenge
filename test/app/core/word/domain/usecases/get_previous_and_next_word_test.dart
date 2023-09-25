import 'package:dictionary/app/core/shared/errors/failures.dart';
import 'package:dictionary/app/core/word/domain/repositories/word_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/usecases/get_previous_and_next_word.dart';
import 'package:dictionary/app/core/word/domain/value_objects/next_and_previous.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mock.dart';

void main() {
  late IGetPreviousAndNextWordUseCase usecase;
  late IWordRepository favoriteRepository;

  setUpAll(() async {
    favoriteRepository = IWordRepositoryMock();
    usecase = GetPreviousAndNextWordUseCase(
      repository: favoriteRepository,
    );
  });

  test("Should return orderWord with specifed values", () async {
    const word = "mock";
    final OrderWord orderWordMock = OrderWord(
      current: "flutter",
      next: "mock",
      previous: "dart",
    );
    when(() => favoriteRepository.getPreviousAndNextWord(any()))
        .thenAnswer((_) async => orderWordMock);

    final result = await usecase.call(word: word);

    verify(() => favoriteRepository.getPreviousAndNextWord(word)).called(1);
    expect(result.current, "flutter");
    expect(result.next, "mock");
    expect(result.previous, "dart");
  });

  test("Should throw error argument is empty", () async {
    const word = "";
    final OrderWord orderWordMock = OrderWord(
      current: "flutter",
      next: "mock",
      previous: "dart",
    );
    when(() => favoriteRepository.getPreviousAndNextWord(any()))
        .thenAnswer((_) async => orderWordMock);

    expect(() async => await usecase.call(word: word),
        throwsA(isA<ArgumentFailure>()));
  });
}
