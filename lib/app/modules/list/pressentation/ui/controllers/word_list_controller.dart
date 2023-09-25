import 'package:flutter/material.dart';

import '../../../../../core/shared/errors/failures.dart';
import '../../../../../core/word/domain/usecases/add_or_delete_favorite_word_usecase.dart';
import '../../../../../core/word/domain/usecases/get_is_favorite_word.dart';
import '../../../../../core/word/domain/usecases/get_word_list_usecase.dart';
import '../../../../../core/word/domain/value_objects/next_and_previous.dart';
import '../states/word_list_states.dart';

class WordListController extends ValueNotifier<WordListState> {
  final List<OrderWord> items = [];
  bool isFavorite = false;
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  final IGetWordListUseCase getListUseCase;
  final IGetIsFavoriteWordUseCase getIsFavoriteWordUseCase;
  final IAddOrDeleteFavoriteWordUseCase addOrDeleteFavoriteWordUseCase;

  WordListController({
    required this.getListUseCase,
    required this.addOrDeleteFavoriteWordUseCase,
    required this.getIsFavoriteWordUseCase,
  }) : super(WordListLoadingState());

  Future<void> getAndVerifyInitalData() async {
    try {
      value = WordListLoadingState();

      List<OrderWord> response =
          await getListUseCase.call(lastIndex: items.length);

      List<OrderWord> list = response;
      items.addAll(list);
      value = WordListSuccessState();
    } on Failure catch (e) {
      value = WordListErrorState();
      throw GenericFailure(message: e.message);
    }
  }

  Future<void> getMoreData() async {
    try {
      isLoading = true;

      List<OrderWord> response =
          await getListUseCase.call(lastIndex: items.length);

      List<OrderWord> list = response;
      items.addAll(list);

      isLoading = false;
    } on Failure catch (e) {
      debugPrint('${e.runtimeType}: ${e.message}');
      value = WordListErrorState();
      throw GenericFailure(message: e.message);
    }
  }

  Future<bool> getFavoriteBox(String word) async {
    return await getIsFavoriteWordUseCase.call(word: word);
  }

  Future<void> setFavorite(String word, bool favoriteState) async {
    await addOrDeleteFavoriteWordUseCase.call(
        word: word, favoriteState: favoriteState);
  }
}
