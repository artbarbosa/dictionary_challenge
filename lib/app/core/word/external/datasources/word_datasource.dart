import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../shared/consts/api_consts.dart';
import '../../../shared/consts/file_consts.dart';
import '../../../shared/errors/failures.dart';
import '../../../shared/services/remote/http_client_service_interface.dart';
import '../../infra/datasource/word_datasource_interface.dart';
import '../../infra/models/word.dart';

class WordDataSource implements IWordDataSource {
  final IHttpClientService client;

  WordDataSource({required this.client});

  @override
  Future<Map<String, String>> getPreviousAndNextWord(String word) async {
    final ByteData data = await rootBundle.load(FileConst.englishFrequency10k);
    final List<String> lines =
        utf8.decode(data.buffer.asUint8List()).split(',');

    final int index = lines.indexOf(word);

    String previous = "";
    String next = "";
    if (index < lines.length - 1 && lines[index + 1].isNotEmpty) {
      next = lines[index + 1];
    }
    if (index != 0 && lines[index - 1].isNotEmpty) {
      previous = lines[index - 1];
    }

    final map = {"next": next, "previous": previous};
    return map;
  }

  @override
  Future<List<String>> getListWord(int startLine, int endLine) async {
    if (startLine > endLine) {
      throw ArgumentFailure(
          message: 'Start line must be less than or equal to end line');
    }

    final linesInRange = <String>[];
    int currentLine = 0;
    final ByteData data = await rootBundle.load(FileConst.englishFrequency10k);
    final List<String> lines =
        utf8.decode(data.buffer.asUint8List()).split(',');

    for (var line in lines) {
      currentLine++;
      if (currentLine >= startLine && currentLine <= endLine) {
        linesInRange.add(line);
      }
      if (currentLine > endLine) {
        break;
      }
    }
    return linesInRange;
  }

  @override
  Future<WordModel> getWord(String word) async {
    if (word.isEmpty) {
      throw ArgumentFailure(message: 'Word is Empty');
    }
    final url = Uri.parse(ApiConst.apiUrl(word));

    final headers = {
      'X-RapidAPI-Key': dotenv.env['KEY'] ?? '',
      'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
    };

    try {
      final response = await client.get(url, headers: headers);
      final data = jsonDecode(response.body);
      return WordModel.fromApiJson(data);
    } on SocketException catch (error) {
      throw ApiFailure(message: error.toString(), code: 500);
    } catch (error) {
      throw GenericFailure(message: error.toString());
    }
  }

  // MOCK DATA API
  // @override
  // Future<WordModel> getWord(String word) async {
  //   if (word.isEmpty) {
  //     throw ArgumentFailure(
  //         message: 'Start line must be less than or equal to end line');
  //   }
  //   // final url = Uri.parse(ApiConst.apiUrl(word));
  //   final url = Uri.parse('https://jsonplaceholder.typicode.com/todos/1');

  //   final headers = {
  //     // 'X-RapidAPI-Key': dotenv.env['RAPIDAPI_KEY'] ?? '',
  //     // 'X-RapidAPI-Key': '651b21c5acmsh150d16d65b04af0p185e39jsnf66920b75083',
  //     'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
  //   };

  //   try {
  //     final response = await client.get(url, headers: headers);

  //     if (response.statusCode == 200 || true) {
  //       // final data = jsonDecode(response.body);
  //       final data = jsonDecode(responseBody);
  //       return WordModel.fromApiJson(data);
  //     }
  //     // else {
  //     //   throw ApiFailure(message: response.body, code: response.statusCode);
  //     // }
  //   } on SocketException catch (error) {
  //     throw ApiFailure(message: error.toString(), code: 500);
  //   } catch (error) {
  //     throw GenericFailure(message: error.toString());
  //   }
  // }
}

const responseBody =
    """{"word":"there","results":[{"definition":"to or toward that place; away from the speaker","partOfSpeech":"adverb","synonyms":["thither"],"antonyms":["here"],"examples":["go there around noon!"]},{"definition":"a location other than here; that place","partOfSpeech":"noun","typeOf":["location"],"antonyms":["here"],"examples":["you can take it from there"]},{"definition":"in or at that place or location","partOfSpeech":null,"antonyms":["here"],"examples":["they have lived there for years","it's not there","that man there"]}],"syllables":{"count":1,"list":["there"]},"pronunciation":{"all":"ðɜr"},"frequency":6.62}""";
