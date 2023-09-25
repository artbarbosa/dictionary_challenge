import 'package:dictionary/app/core/shared/errors/failures.dart';
import 'package:dictionary/app/core/word/domain/repositories/word_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/usecases/get_word_list_usecase.dart';
import 'package:dictionary/app/core/word/infra/models/word.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mock.dart';

void main() {
  late IGetWordListUseCase usecase;
  late IWordRepository wordRepository;

  setUpAll(() async {
    wordRepository = IWordRepositoryMock();
    usecase = GetWordListUseCase(
      repository: wordRepository,
    );
  });

  test("Should return List OrderWordModel with specifed values", () async {
    const lastIndexMock = 1;
    final orderWordModelMock = OrderWordModel(
      current: "mock",
      previous: "next",
      next: "pronunciation",
    );

    when(() => wordRepository.getWordList(any()))
        .thenAnswer((_) async => [orderWordModelMock]);

    final result = await usecase.call(lastIndex: lastIndexMock);

    verify(() => wordRepository.getWordList(lastIndexMock)).called(1);
    expect(result.length, 1);
    expect(result.first.next, "pronunciation");
  });

  test("Should throw ArgumentFailure when last index is less than zero",
      () async {
    const lastIndexMock = -1;
    final orderWordModelMock = OrderWordModel(
      current: "mock",
      previous: "next",
      next: "pronunciation",
    );
    when(() => wordRepository.getWordList(any()))
        .thenAnswer((_) async => [orderWordModelMock]);

    expect(() async => await usecase.call(lastIndex: lastIndexMock),
        throwsA(isA<ArgumentFailure>()));
  });
}
