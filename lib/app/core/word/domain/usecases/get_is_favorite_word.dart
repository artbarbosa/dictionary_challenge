import '../../../shared/errors/failures.dart';
import '../repositories/favorite_repository_interface.dart';

sealed class IGetIsFavoriteWordUseCase {
  Future<bool> call({required String word});
}

class GetIsFavoriteWordUseCase implements IGetIsFavoriteWordUseCase {
  final IFavoriteRepository repository;

  GetIsFavoriteWordUseCase({
    required this.repository,
  });

  @override
  Future<bool> call({required String word}) async {
    try {
      if (word.isEmpty) {
        throw ArgumentFailure(
            message: "GetIsFavoriteWordUseCase - Word Es Empty");
      }
      return await repository.getIsFavoriteWordUseCase(word: word);
    } on ArgumentFailure {
      rethrow;
    } catch (e) {
      throw GenericFailure(message: e.toString());
    }
  }
}
