import '../../../shared/errors/failures.dart';
import '../../infra/models/word.dart';
import '../entities/word_entity.dart';
import '../repositories/word_repository_interface.dart';

sealed class IGetWordInfoUseCase {
  Future<WordEntity> call({required String word});
}

class GetWordInfoUseCase implements IGetWordInfoUseCase {
  final IWordRepository repository;

  GetWordInfoUseCase({
    required this.repository,
  });

  @override
  Future<WordEntity> call({required String word}) async {
    try {
      if (word.isEmpty) {
        throw ArgumentFailure(message: "GetWordInfoUseCase - Word is Empty");
      }
      WordEntity? wordEntity;
      wordEntity = await repository.getLocalWordInfo(word);
      wordEntity ??= await repository.getWordInfo(word);
      repository.saveWordInfo(word, wordEntity as WordModel);
      return wordEntity;
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.message, code: e.code);
    } on ArgumentFailure {
      rethrow;
    } catch (e) {
      throw GenericFailure(message: e.toString());
    }
  }
}
