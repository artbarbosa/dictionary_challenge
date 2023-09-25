import '../entities/word_entity.dart';

abstract class IHistoryRepository {
  Future<List<WordEntity>> getHistoryList();
}
