import '../../../../../core/word/domain/usecases/get_word_favorite_list_usecase.dart';
import '../../../../../core/word/infra/models/word.dart';

class FavoriteController {
  List<String> wordKeys = [];
  List<WordModel> words = [];
  final IGetWordFavoriteListUseCase usecase;

  FavoriteController({required this.usecase});

  Future<void> loadFavorites() async {
    final listFavorites = await usecase.call();
    words = listFavorites as List<WordModel>;
  }
}
