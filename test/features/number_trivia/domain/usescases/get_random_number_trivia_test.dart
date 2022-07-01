import 'package:clean_architecture/core/usecases/usecase.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([
  NumberTriviaRepository
], customMocks: [
  MockSpec<NumberTriviaRepository>(
      as: #MockConcreteNumberTrivia, returnNullOnMissingStub: true)
])
class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late int tNumber;
  late NumberTrivia tNumberTrivia;
  late GetRandomNumberTrivia usecase;
  late NumberTriviaRepository mockNumberTriviaRepository;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
    tNumberTrivia = NumberTrivia(text: "test", number: 1);
  });

  test('should get trivia from the repository', () async {
    // arrange
    // it returns null here instead of the right
    when(mockNumberTriviaRepository.getRandomTriviaNumber())
        .thenAnswer((_) async => Right(tNumberTrivia));

    // act
    final result = await usecase(NoParams());

    //assert

    expect(result, equals(Right(tNumberTrivia)));

    verify(mockNumberTriviaRepository.getRandomTriviaNumber());

    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
