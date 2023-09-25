import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../../../modules/favorites/presentation/ui/controllers/favorite_controller.dart';
import '../../../modules/history/presentation/ui/controllers/history_controller.dart';
import '../../../modules/info/presentation/ui/controllers/info_controller.dart';
import '../../../modules/list/pressentation/ui/controllers/word_list_controller.dart';
import '../../word/domain/repositories/favorite_repository_interface.dart';
import '../../word/domain/repositories/history_repository_interface.dart';
import '../../word/domain/repositories/word_repository_interface.dart';
import '../../word/domain/usecases/add_or_delete_favorite_word_usecase.dart';
import '../../word/domain/usecases/get_is_favorite_word.dart';
import '../../word/domain/usecases/get_previous_and_next_word.dart';
import '../../word/domain/usecases/get_word_favorite_list_usecase.dart';
import '../../word/domain/usecases/get_word_history_list_usecase.dart';
import '../../word/domain/usecases/get_word_info_usercase.dart';
import '../../word/domain/usecases/get_word_list_usecase.dart';
import '../../word/external/datasources/word_datasource.dart';
import '../../word/infra/datasource/word_datasource_interface.dart';
import '../../word/infra/repositories/favorite_repository.dart';
import '../../word/infra/repositories/history_repository.dart';
import '../../word/infra/repositories/word_repository.dart';
import '../services/local/hive_service.dart';
import '../services/remote/http_client_service.dart';
import '../services/remote/http_client_service_interface.dart';

class Inject {
  static initialize() async {
    final getIt = GetIt.I;

    FlutterTts flutterTts = FlutterTts();
    if (await flutterTts.isLanguageAvailable("en-US")) {
      await flutterTts.setLanguage("en-US");
    }
    getIt.registerLazySingleton<FlutterTts>(() => flutterTts);
    getIt.registerLazySingleton<Client>(() => Client());

    getIt.registerLazySingleton<IHiveService>(() => HiveService());
    getIt.registerLazySingleton<IHttpClientService>(
        () => HttpClientService(getIt()));

    getIt.registerLazySingleton<IWordDataSource>(
        () => WordDataSource(client: getIt()));

    getIt.registerLazySingleton<IWordRepository>(() => WordRepository(
          localService: getIt(),
          dataSource: getIt(),
        ));
    getIt.registerLazySingleton<IFavoriteRepository>(() => FavoriteRepository(
          localService: getIt(),
        ));
    getIt.registerLazySingleton<IHistoryRepository>(() => HistoryRepository(
          localService: getIt(),
        ));

    getIt.registerLazySingleton<IAddOrDeleteFavoriteWordUseCase>(
        () => AddOrDeleteFavoriteWordUseCase(
              wordRepository: getIt(),
              favoriteRepository: getIt(),
            ));
    getIt.registerLazySingleton<IGetIsFavoriteWordUseCase>(
        () => GetIsFavoriteWordUseCase(repository: getIt()));
    getIt.registerLazySingleton<IGetWordFavoriteListUseCase>(
        () => GetWordFavoriteListUseCase(
              repository: getIt(),
            ));
    getIt.registerLazySingleton<IGetWordHistoryListUseCase>(
        () => GetWordHistoryListUseCase(
              repository: getIt(),
            ));
    getIt.registerLazySingleton<IGetWordInfoUseCase>(() => GetWordInfoUseCase(
          repository: getIt(),
        ));
    getIt.registerLazySingleton<IGetWordListUseCase>(() => GetWordListUseCase(
          repository: getIt(),
        ));
    getIt.registerLazySingleton<IGetPreviousAndNextWordUseCase>(
        () => GetPreviousAndNextWordUseCase(
              repository: getIt(),
            ));

    getIt.registerLazySingleton<FavoriteController>(() => FavoriteController(
          usecase: getIt(),
        ));
    getIt.registerLazySingleton<HistoryController>(() => HistoryController(
          usecase: getIt(),
        ));
    getIt.registerLazySingleton<InfoController>(() => InfoController(
          getWordUseCase: getIt(),
          addOrDeleteFavoriteWordUseCase: getIt(),
          getIsFavoriteWordUseCase: getIt(),
          flutterTts: getIt(),
          getPreviousAndNextWordUseCase: getIt(),
        ));
    getIt.registerLazySingleton<WordListController>(() => WordListController(
          getListUseCase: getIt(),
          addOrDeleteFavoriteWordUseCase: getIt(),
          getIsFavoriteWordUseCase: getIt(),
        ));
  }
}
