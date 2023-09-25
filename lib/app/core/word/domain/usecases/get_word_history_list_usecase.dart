import '../entities/word_entity.dart';
import '../repositories/history_repository_interface.dart';

sealed class IGetWordHistoryListUseCase {
  Future<List<WordEntity>> call();
}

class GetWordHistoryListUseCase implements IGetWordHistoryListUseCase {
  final IHistoryRepository repository;

  GetWordHistoryListUseCase({
    required this.repository,
  });

  @override
  Future<List<WordEntity>> call() async {
    final history = await repository.getHistoryList();
    return history.reversed.toList();
  }
}
