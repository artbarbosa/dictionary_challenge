import 'package:hive_flutter/hive_flutter.dart';

import '../../../word/infra/models/word.dart';
import '../../consts/local_store_consts.dart';

abstract class IHiveService {
  late Box<bool> _favoriteBox;
  late Box<WordModel> _wordListBox;
  late Box<dynamic> _historyBox;

  Box<bool> get favoriteBox => _favoriteBox;
  Box<WordModel> get wordListBox => _wordListBox;
  Box<dynamic> get historyBox => _historyBox;

  Future<void> initialize();
}

class HiveService implements IHiveService {
  @override
  late Box<bool> _favoriteBox;
  @override
  late Box<dynamic> _historyBox;
  @override
  late Box<WordModel> _wordListBox;

  @override
  Box<dynamic> get historyBox => _historyBox;
  @override
  Box<WordModel> get wordListBox => _wordListBox;
  @override
  Box<bool> get favoriteBox => _favoriteBox;

  @override
  Future<void> initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(WordModelAdapter());
    Hive.registerAdapter(OrderWordModelAdapter());
    _favoriteBox = await Hive.openBox<bool>(LocalStorageConst.favoriteBoxKey);
    _wordListBox =
        await Hive.openBox<WordModel>(LocalStorageConst.wordListBoxKey);
    _historyBox = await Hive.openBox<dynamic>(LocalStorageConst.historyBoxKey);
  }
}
