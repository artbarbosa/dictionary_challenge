import 'dart:convert';
import 'dart:io';

import 'package:dictionary/app/core/shared/errors/failures.dart';
import 'package:dictionary/app/core/shared/services/remote/http_client_service_interface.dart';
import 'package:dictionary/app/core/word/external/datasources/word_datasource.dart';
import 'package:dictionary/app/core/word/infra/datasource/word_datasource_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mock/mock.dart';

main() {
  late IWordDataSource dataSource;
  late IHttpClientService client;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    client = IHttpClientServiceMock();
    dataSource = WordDataSource(client: client);
    registerFallbackValue(Uri());
    await dotenv.load(fileName: "assets/.env");
  });

  group("WordDataSource - getWord", () {
    test('Should return a WordModel on successful HTTP response', () async {
      when(() => client.get(any(), headers: any(named: 'headers'))).thenAnswer(
        (_) async => Response(
          mockResponseBodyWord.toString(),
          200,
        ),
      );

      final result = await dataSource.getWord('there');

      expect(result.word, "there");
    });

    test('Should throw ApiFailure on socket exception', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenThrow(const SocketException('No internet connection'));

      expect(() async => await dataSource.getWord("there"),
          throwsA(isA<ApiFailure>()));
    });

    test('Should throw GenericFailure on exceptions', () async {
      when(() => client.get(any(), headers: any(named: 'headers')))
          .thenThrow(Exception('Some unexpected error'));

      expect(() async => await dataSource.getWord("there"),
          throwsA(isA<GenericFailure>()));
    });
  });

  group("WordDataSource - getListWord", () {
    test('should returns specified', () async {
      const startLine = 1;
      const endLine = 10;

      final lines = await dataSource.getListWord(startLine, endLine);

      expect(lines, hasLength(endLine - startLine + 1));
      expect(lines[0], 'about');
      expect(lines[1], 'search');
      expect(lines[2], 'other');
    });

    test('shoudl throws ArgumentFailure if startLine > endLine', () async {
      const startLine = 10;
      const endLine = 1;

      expect(() async => await dataSource.getListWord(startLine, endLine),
          throwsA(isA<ArgumentFailure>()));
    });

    test('should reads lines from the file', () async {
      const startLine = 1;
      const endLine = 5;

      final ByteData data = await rootBundle.load(mockWordListCSV);
      final List<String> expectedLines =
          utf8.decode(data.buffer.asUint8List()).split(',');

      final lines = await dataSource.getListWord(startLine, endLine);

      expect(lines, hasLength(endLine - startLine + 1));
      expect(lines, equals(expectedLines.sublist(startLine - 1, endLine)));
    });
  });
}
