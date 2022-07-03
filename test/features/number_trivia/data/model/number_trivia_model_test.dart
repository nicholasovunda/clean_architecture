import 'dart:convert';

import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tNumberTriviaModel = NumberTriviaModel(text: "Test Text", number: 1);

  test("should be a subclass of NumberTrivia entity", () async {
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });
  group('fromJson', () {
    test('should return a valid model when the json number is an integer',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("trivia.json"));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should return a valid model when the json number is an double',
        () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("trivia_double.json"));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });
  });
  group('toJson', () {
    test('should return a json map containing the proper data ', () {
      //act
      final result = tNumberTriviaModel.toJson();
      final expectedMap = {
        "text": "Test Text",
        "number": 1,
      };
      //assert
      expect(result, expectedMap);
    });
  });
}
