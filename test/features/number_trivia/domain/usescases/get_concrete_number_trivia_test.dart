import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_architecture/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean_architecture/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

@GenerateMocks([
  NumberTriviaRepository
], customMocks: [
  MockSpec<NumberTriviaRepository>(
      as: #MockRandomNumberTrivia, returnNullOnMissingStub: true)
])
void main() {
  late int tNumber;
  late NumberTrivia tNumberTrivia;
  late GetConcreteNumberTrivia usecase;
  late NumberTriviaRepository mockRNumberTriviaRepository;
  setUp(() {
    mockRNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockRNumberTriviaRepository);
    tNumber = 1;
    tNumberTrivia = NumberTrivia(text: "test", number: tNumber);
  });

  test('should get trivia for the number from the repository', () async {
    // arrange
    // it returns null here instead of the right
    when(mockRNumberTriviaRepository.getConcreteNumberTrivia(tNumber))
        .thenAnswer((_) async => Right(tNumberTrivia));
    // act
    final result = await usecase(Params(number: tNumber));

    //assert

    expect(result, equals(Right(tNumberTrivia)));

    verify(mockRNumberTriviaRepository.getConcreteNumberTrivia(tNumber));

    verifyNoMoreInteractions(mockRNumberTriviaRepository);
  });
}
