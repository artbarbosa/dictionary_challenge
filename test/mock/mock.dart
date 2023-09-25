import 'package:dictionary/app/core/shared/services/remote/http_client_service_interface.dart';
import 'package:dictionary/app/core/word/domain/repositories/favorite_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/repositories/history_repository_interface.dart';
import 'package:dictionary/app/core/word/domain/repositories/word_repository_interface.dart';
import 'package:mocktail/mocktail.dart';

class IHttpClientServiceMock extends Mock implements IHttpClientService {}

class IFavoriteRepositoryMock extends Mock implements IFavoriteRepository {}

class IWordRepositoryMock extends Mock implements IWordRepository {}

class IHistoryRepositoryMock extends Mock implements IHistoryRepository {}

const mockWordListCSV = "test/mock/mock_list_word.csv";

const String mockResponseBodyWord = '''
{
   "word":"there",
   "results":[
      {
         "definition":"to or toward that place; away from the speaker",
         "partOfSpeech":"adverb",
         "synonyms":[
            "thither"
         ],
         "antonyms":[
            "here"
         ],
         "examples":[
            "go there around noon!"
         ]
      },
      {
         "definition":"a location other than here; that place",
         "partOfSpeech":"noun",
         "typeOf":[
            "location"
         ],
         "antonyms":[
            "here"
         ],
         "examples":[
            "you can take it from there"
         ]
      },
      {
         "definition":"in or at that place or location",
         "partOfSpeech":null,
         "antonyms":[
            "here"
         ],
         "examples":[
            "they have lived there for years",
            "it's not there",
            "that man there"
         ]
      }
   ],
   "syllables":{
      "count":1,
      "list":[
         "there"
      ]
   },
   "pronunciation":{
      "all":""
   },
   "frequency":6.62
}''';
