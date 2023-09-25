import 'package:dictionary/app/core/word/domain/repositories/favorite_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/usecases/get_word_favorite_list_usecase.dart';
import 'package:dictionary/app/core/word/infra/models/word.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mock.dart';

void main() {
  late IGetWordFavoriteListUseCase usecase;
  late IFavoriteRepository favoriteRepository;

  setUpAll(() async {
    favoriteRepository = IFavoriteRepositoryMock();
    usecase = GetWordFavoriteListUseCase(
      repository: favoriteRepository,
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

    when(() => favoriteRepository.getWordFavoriteListUseCase())
        .thenAnswer((_) async => [wordModelMock]);

    final result = await usecase.call();

    verify(() => favoriteRepository.getWordFavoriteListUseCase()).called(1);
    expect(result.length, 1);
    expect(result.first.pronunciation, "pronunciation");
    expect(result.first.word, "mock");
  });
}
