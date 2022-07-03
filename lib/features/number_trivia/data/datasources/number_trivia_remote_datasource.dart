import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// Calls the http://numbersapi.com/{number} endpoint
  ///
  /// Throws a [ServerException] for all error code.
  Future<NumberTriviaModel>? getConcreteNumberTrivia(int number);

  /// Call the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error code.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
