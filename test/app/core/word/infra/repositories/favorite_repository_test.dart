import 'package:dictionary/app/core/shared/services/local/hive_service.dart';
import 'package:dictionary/app/core/word/infra/repositories/favorite_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class HiveServiceMock extends Mock implements IHiveService {}

void main() {
  late FavoriteRepository repository;
  late HiveServiceMock localService;

  setUpAll(() async {
    localService = HiveServiceMock();
    repository = FavoriteRepository(
      localService: localService,
    );
  });

  group("FavoriteRepository - addOrDeleteFavoriteWord ", () {
    test("Should", () {
      const word = "mock";
      // when(() => localService.favoriteBox.put(word, true));

      repository.addOrDeleteFavoriteWord(favoriteState: true, word: word);

      verify(() => repository.addOrDeleteFavoriteWord(
          favoriteState: true, word: word)).called(1);

      // verify(() => localService.favoriteBox.put(word, true)).called(1);
    });
  });
}
