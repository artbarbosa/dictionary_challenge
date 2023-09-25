import '../../../shared/services/local/hive_service.dart';
import '../../domain/repositories/favorite_repository_interface.dart';
import '../../infra/models/word.dart';

class FavoriteRepository implements IFavoriteRepository {
  final IHiveService localService;

  FavoriteRepository({required this.localService});

  @override
  void addOrDeleteFavoriteWord(
      {required String word, required bool favoriteState}) async {
    final favoriteBox = localService.favoriteBox;
    if (favoriteState) {
      favoriteBox.put(word, true);
    } else {
      favoriteBox.delete(word);
    }
  }

  @override
  Future<bool> getIsFavoriteWordUseCase({required String word}) async {
    final favoriteBox = localService.favoriteBox;
    final isFavorite = favoriteBox.get(word, defaultValue: false) ?? false;
    return isFavorite;
  }

  @override
  Future<List<WordModel>> getWordFavoriteListUseCase() async {
    final favoriteBox = localService.favoriteBox;
    var listBox = localService.wordListBox;

    List<String> wordKeys = [];
    List<WordModel> localWords = [];

    wordKeys = favoriteBox.keys.toList().cast<String>();
    for (var key in wordKeys) {
      if (listBox.get(key) != null) {
        localWords.add(listBox.get(key)!);
      }
    }

    return localWords;
  }
}
