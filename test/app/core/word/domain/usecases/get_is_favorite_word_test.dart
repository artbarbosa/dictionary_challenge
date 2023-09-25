import 'package:dictionary/app/core/word/domain/repositories/favorite_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/usecases/get_is_favorite_word.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mock.dart';

void main() {
  late IGetIsFavoriteWordUseCase usecase;
  late IFavoriteRepository favoriteRepository;

  setUpAll(() async {
    favoriteRepository = IFavoriteRepositoryMock();
    usecase = GetIsFavoriteWordUseCase(
      repository: favoriteRepository,
    );
  });

  test("Should return isFavorite as false", () async {
    const word = "mock";
    when(() => favoriteRepository.getIsFavoriteWordUseCase(
        word: any(named: "word"))).thenAnswer((_) async => false);

    final isFavorite = await usecase.call(word: word);

    verify(() => favoriteRepository.getIsFavoriteWordUseCase(word: word))
        .called(1);
    expect(isFavorite, false);
  });

  test("Should return isFavorite as true", () async {
    const word = "mock";
    when(() => favoriteRepository.getIsFavoriteWordUseCase(
        word: any(named: "word"))).thenAnswer((_) async => true);

    final isFavorite = await usecase.call(word: word);

    verify(() => favoriteRepository.getIsFavoriteWordUseCase(word: word))
        .called(1);
    expect(isFavorite, true);
  });
}
