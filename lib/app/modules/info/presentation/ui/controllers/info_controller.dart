import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../../../core/shared/errors/failures.dart';
import '../../../../../core/word/domain/entities/word_entity.dart';
import '../../../../../core/word/domain/usecases/add_or_delete_favorite_word_usecase.dart';
import '../../../../../core/word/domain/usecases/get_is_favorite_word.dart';
import '../../../../../core/word/domain/usecases/get_previous_and_next_word.dart';
import '../../../../../core/word/domain/usecases/get_word_info_usercase.dart';
import '../../../../../core/word/domain/value_objects/next_and_previous.dart';
import '../../../../../core/word/infra/models/word.dart';
import '../states/info_states.dart';

class InfoController extends ValueNotifier<InfoStates> {
  WordModel? wordModel;
  OrderWord? orderWord;
  bool isFavorite = false;
  final FlutterTts flutterTts;
  final IGetWordInfoUseCase getWordUseCase;
  final IGetIsFavoriteWordUseCase getIsFavoriteWordUseCase;
  final IAddOrDeleteFavoriteWordUseCase addOrDeleteFavoriteWordUseCase;
  final IGetPreviousAndNextWordUseCase getPreviousAndNextWordUseCase;

  InfoController(
      {required this.flutterTts,
      required this.getWordUseCase,
      required this.getIsFavoriteWordUseCase,
      required this.addOrDeleteFavoriteWordUseCase,
      required this.getPreviousAndNextWordUseCase})
      : super(InfoStatesLoadingState());

  Future<void> getWord(String word) async {
    try {
      value = InfoStatesLoadingState();
      final WordEntity response = await getWordUseCase.call(word: word);
      wordModel = response as WordModel;
      value = InfoStatesSuccessState();
    } on Failure catch (e) {
      value = InfoStatesErrorState();
      throw GenericFailure(message: e.message);
    }
  }

  Future<void> getPreviousAndNextWord(String word) async {
    orderWord = await getPreviousAndNextWordUseCase.call(word: word);
  }

  Future speak(String word) async {
    await flutterTts.speak(word);
  }

  Future stopTTS() async {
    await flutterTts.stop();
  }

  void getFavoriteBox(String word) async {
    isFavorite = await getIsFavoriteWordUseCase.call(word: word);
  }

  void setFavorite(String word, bool favoriteState) {
    addOrDeleteFavoriteWordUseCase.call(
      word: word,
      favoriteState: favoriteState,
    );
  }
}
