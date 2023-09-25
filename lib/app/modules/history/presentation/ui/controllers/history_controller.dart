import '../../../../../core/word/domain/usecases/get_word_history_list_usecase.dart';
import '../../../../../core/word/infra/models/word.dart';

class HistoryController {
  List<WordModel> words = [];
  final IGetWordHistoryListUseCase usecase;

  HistoryController({required this.usecase});

  void loadHistory() async {
    final listHistory = await usecase.call();
    words = listHistory as List<WordModel>;
  }
}
