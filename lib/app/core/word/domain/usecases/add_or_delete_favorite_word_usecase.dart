import '../../../shared/errors/failures.dart';
import '../../infra/models/word.dart';
import '../entities/word_entity.dart';
import '../repositories/favorite_repository_interface.dart';
import '../repositories/word_repository_interface.dart';

sealed class IAddOrDeleteFavoriteWordUseCase {
  Future<void> call({required String word, required bool favoriteState});
}

class AddOrDeleteFavoriteWordUseCase
    implements IAddOrDeleteFavoriteWordUseCase {
  final IFavoriteRepository favoriteRepository;
  final IWordRepository wordRepository;

  AddOrDeleteFavoriteWordUseCase({
    required this.wordRepository,
    required this.favoriteRepository,
  });

  @override
  Future<void> call({required String word, required bool favoriteState}) async {
    try {
      if (word.isEmpty) {
        throw ArgumentFailure(
            message: "AddOrDeleteFavoriteWordUseCase - Word Es Empty");
      }
      WordEntity? wordEntity;
      wordEntity = await wordRepository.getLocalWordInfo(word);
      wordEntity ??= await wordRepository.getWordInfo(word);
      wordRepository.saveWordInfo(word, wordEntity as WordModel);
      favoriteRepository.addOrDeleteFavoriteWord(
        word: word,
        favoriteState: favoriteState,
      );
    } on ApiFailure catch (e) {
      throw ApiFailure(code: e.code, message: e.message);
    } on ArgumentFailure {
      rethrow;
    } catch (e) {
      throw GenericFailure(message: e.toString());
    }
  }
}
