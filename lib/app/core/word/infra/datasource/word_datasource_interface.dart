import '../../infra/models/word.dart';

abstract class IWordDataSource {
  Future<List<String>> getListWord(int startLine, int endLine);
  Future<WordModel> getWord(String word);
  Future<Map<String, String>> getPreviousAndNextWord(String word);
}
