import '../../../shared/errors/failures.dart';
import '../repositories/word_repository_interface.dart';
import '../value_objects/next_and_previous.dart';

sealed class IGetPreviousAndNextWordUseCase {
  Future<OrderWord> call({required String word});
}

class GetPreviousAndNextWordUseCase implements IGetPreviousAndNextWordUseCase {
  final IWordRepository repository;

  GetPreviousAndNextWordUseCase({
    required this.repository,
  });

  @override
  Future<OrderWord> call({required String word}) async {
    try {
      if (word.isEmpty) {
        throw ArgumentFailure(
            message: "GetPreviousAndNextWordUseCase - Word Es Empty");
      }
      return await repository.getPreviousAndNextWord(word);
    } on ArgumentFailure {
      rethrow;
    } catch (e) {
      throw GenericFailure(message: e.toString());
    }
  }
}
