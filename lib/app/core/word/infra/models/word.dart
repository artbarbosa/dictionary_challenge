// ignore_for_file: must_be_immutable

import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/word_entity.dart';
import '../../domain/value_objects/next_and_previous.dart';

part 'word.g.dart';

@HiveType(typeId: 1)
class WordModel extends HiveObject implements WordEntity {
  @override
  @HiveField(0)
  final String word;

  @override
  @HiveField(1)
  final Map<String, List<String>> definitions;

  @override
  @HiveField(2)
  final String pronunciation;

  @override
  @HiveField(3)
  final OrderWord? orderWord;

  WordModel({
    required this.word,
    required this.definitions,
    required this.pronunciation,
    required this.orderWord,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      orderWord: null,
      word: json['word'],
      definitions: Map<String, List<String>>.from(json['definitions']),
      pronunciation: json['pronunciation'],
    );
  }

  factory WordModel.fromApiJson(Map<String, dynamic> json) {
    List<dynamic> results = [];
    if (json['results'] != null) {
      results = (json['results'] as List<dynamic>);
    }
    final definitionMap = <String, List<String>>{};

    for (final result in results) {
      final partOfSpeech = result['partOfSpeech'];
      final definition = result['definition'];
      if (partOfSpeech != null && definition != null) {
        if (definitionMap[partOfSpeech] == null) {
          definitionMap[partOfSpeech] = [];
        }
        definitionMap[partOfSpeech]!.add(definition);
      }
    }

    String pronunciation;
    if (json['pronunciation'].runtimeType == String) {
      pronunciation = json['pronunciation'];
    } else {
      pronunciation = json['pronunciation']['all'];
    }

    return WordModel(
      orderWord: null,
      word: json['word'],
      definitions: definitionMap,
      pronunciation: pronunciation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'definitions': definitions,
      'pronunciation': pronunciation,
    };
  }

  @override
  List<Object> get props => throw UnimplementedError();

  @override
  bool? get stringify => throw UnimplementedError();
}

@HiveType(typeId: 2)
class OrderWordModel extends HiveObject implements OrderWord {
  @override
  @HiveField(0)
  final String next;

  @override
  @HiveField(1)
  final String current;

  @override
  @HiveField(2)
  final String previous;

  OrderWordModel({
    required this.next,
    required this.current,
    required this.previous,
  });

  factory OrderWordModel.fromJson(Map<String, dynamic> json) {
    return OrderWordModel(
      current: json['current'],
      next: json['next'],
      previous: json['previous'],
    );
  }

  factory OrderWordModel.fromApiJson(Map<String, dynamic> json) {
    return OrderWordModel(
      current: json['current'],
      next: json['next'],
      previous: json['previous'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current': current,
      'next': next,
      'previous': previous,
    };
  }
}
