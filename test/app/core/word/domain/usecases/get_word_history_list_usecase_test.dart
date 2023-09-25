import 'package:dictionary/app/core/word/domain/repositories/history_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/usecases/get_word_history_list_usecase.dart';
import 'package:dictionary/app/core/word/infra/models/word.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mock.dart';

void main() {
  late IGetWordHistoryListUseCase usecase;
  late IHistoryRepository historyRepository;

  setUpAll(() async {
    historyRepository = IHistoryRepositoryMock();
    usecase = GetWordHistoryListUseCase(
      repository: historyRepository,
    );
  });

  test("Should return List WordModel with specifed values", () async {
    const word = "mock";
    final wordModelMock = WordModel(
      word: word,
      definitions: {},
      pronunciation: "pronunciation",
      orderWord: null,
    );

    when(() => historyRepository.getHistoryList())
        .thenAnswer((_) async => [wordModelMock]);

    final result = await usecase.call();

    verify(() => historyRepository.getHistoryList()).called(1);
    expect(result.length, 1);
    expect(result.first.pronunciation, "pronunciation");
    expect(result.first.word, "mock");
  });
}
