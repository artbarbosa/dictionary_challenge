import '../../../shared/errors/failures.dart';
import '../repositories/word_repository_interface.dart';
import '../value_objects/next_and_previous.dart';

sealed class IGetWordListUseCase {
  Future<List<OrderWord>> call({required int lastIndex});
}

class GetWordListUseCase implements IGetWordListUseCase {
  final IWordRepository repository;

  GetWordListUseCase({
    required this.repository,
  });

  @override
  Future<List<OrderWord>> call({required int lastIndex}) {
    try {
      if (lastIndex < 0) {
        throw ArgumentFailure(
            message: "GetWordListUseCase - last index is less than zero");
      }
      return repository.getWordList(lastIndex);
    } on ApiFailure catch (e) {
      throw ApiFailure(message: e.message, code: e.code);
    } on ArgumentFailure {
      rethrow;
    } catch (e) {
      throw GenericFailure(message: e.toString());
    }
  }
}
