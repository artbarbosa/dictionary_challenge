import '../entities/word_entity.dart';

abstract class IFavoriteRepository {
  void addOrDeleteFavoriteWord(
      {required String word, required bool favoriteState});
  Future<bool> getIsFavoriteWordUseCase({required String word});
  Future<List<WordEntity>> getWordFavoriteListUseCase();
}
