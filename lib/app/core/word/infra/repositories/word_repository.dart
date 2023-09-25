// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';

import '../../../shared/consts/local_store_consts.dart';
import '../../../shared/errors/failures.dart';
import '../../../shared/services/local/hive_service.dart';
import '../../domain/entities/word_entity.dart';
import '../../domain/repositories/word_repository_interface.dart';
import '../../domain/value_objects/next_and_previous.dart';
import '../../infra/models/word.dart';
import '../datasource/word_datasource_interface.dart';

class WordRepository implements IWordRepository {
  final IWordDataSource dataSource;
  final IHiveService localService;

  WordRepository({
    required this.dataSource,
    required this.localService,
  });

  final int size = 30;

  @override
  Future<List<OrderWord>> getWordList(int lastIndex) async {
    final List<OrderWord> orderWordList = [];
    List<String> wordsList =
        await dataSource.getListWord(lastIndex, lastIndex + size);

    for (var index = 0; index < wordsList.length; index++) {
      String previous = "";
      String next = "";

      if (index < wordsList.length - 1 && wordsList[index + 1].isNotEmpty) {
        next = wordsList[index + 1];
      }
      if (index != 0 && wordsList[index - 1].isNotEmpty) {
        next = wordsList[index - 1];
      }
      orderWordList.add(
        OrderWord(
          next: next,
          current: wordsList[index],
          previous: previous,
        ),
      );
    }
    return orderWordList;
  }

  @override
  Future<WordModel> getWordInfo(String word) async {
    try {
      final WordModel response = await dataSource.getWord(word);
      return response;
    } catch (e) {
      throw GenericFailure(message: e.toString());
    }
  }

  @override
  Future<WordModel?> getLocalWordInfo(String word) async {
    var box = localService.wordListBox;
    WordModel? wordModel = box.get(word);
    return wordModel;
  }

  @override
  Future<void> saveWordInfo(String word, WordEntity? wordModel) async {
    var box = localService.wordListBox;
    var historyBox = localService.historyBox;
    if (wordModel != null) {
      await box.put(word, wordModel as WordModel);
      final List<WordModel> historyList = historyBox.get(
          LocalStorageConst.historyList,
          defaultValue: <WordModel>[])!.cast<WordModel>();
      if (historyList.isNotEmpty && historyList.length >= 30) {
        historyList.removeAt(0);
      }
      final contain =
          historyList.firstWhereOrNull((element) => element.word == word);
      if (contain == null) {
        historyList.add(wordModel);
      }
      await historyBox.put('list', historyList);
    }
  }

  @override
  Future<OrderWord> getPreviousAndNextWord(String word) async {
    final map = await dataSource.getPreviousAndNextWord(word);
    return OrderWord(
      next: map["next"] ?? "",
      current: word,
      previous: map["previous"] ?? "",
    );
  }
}
