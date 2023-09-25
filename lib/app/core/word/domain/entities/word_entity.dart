import 'package:equatable/equatable.dart';

import '../value_objects/next_and_previous.dart';

class WordEntity extends Equatable {
  final String word;
  final Map<String, List<String>> definitions;
  final String pronunciation;
  final OrderWord? orderWord;

  const WordEntity({
    required this.word,
    required this.definitions,
    required this.pronunciation,
    required this.orderWord,
  });

  @override
  List<Object> get props => [word, definitions, pronunciation];
}
