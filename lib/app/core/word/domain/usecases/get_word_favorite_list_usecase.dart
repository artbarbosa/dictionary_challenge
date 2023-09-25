import '../entities/word_entity.dart';
import '../repositories/favorite_repository_interface.dart';

sealed class IGetWordFavoriteListUseCase {
  Future<List<WordEntity>> call();
}

class GetWordFavoriteListUseCase implements IGetWordFavoriteListUseCase {
  final IFavoriteRepository repository;

  GetWordFavoriteListUseCase({
    required this.repository,
  });

  @override
  Future<List<WordEntity>> call() async {
    return await repository.getWordFavoriteListUseCase();
  }
}
