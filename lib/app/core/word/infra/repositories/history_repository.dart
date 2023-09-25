import '../../../shared/consts/local_store_consts.dart';
import '../../../shared/errors/failures.dart';
import '../../../shared/services/local/hive_service.dart';
import '../../domain/repositories/history_repository_interface.dart';
import '../models/word.dart';

class HistoryRepository implements IHistoryRepository {
  final IHiveService localService;

  HistoryRepository({required this.localService});

  @override
  Future<List<WordModel>> getHistoryList() async {
    try {
      var box = localService.historyBox;
      List<WordModel> history = box.get(LocalStorageConst.historyList,
          defaultValue: <WordModel>[])!.cast<WordModel>();
      return history;
    } catch (e) {
      throw GenericFailure(message: e.toString());
    }
  }
}
