import '../entities/word_entity.dart';
import '../value_objects/next_and_previous.dart';

abstract class IWordRepository {
  Future<List<OrderWord>> getWordList(int lastIndex);
  Future<WordEntity> getWordInfo(String word);
  Future<WordEntity?> getLocalWordInfo(String word);
  Future<void> saveWordInfo(String word, WordEntity? wordObj);
  Future<OrderWord> getPreviousAndNextWord(String word);
}
