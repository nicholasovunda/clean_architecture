import 'package:clean_architecture/core/platform/network_info.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean_architecture/features/number_trivia/data/datasources/number_trivia_remote_datasource.dart';
import 'package:clean_architecture/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:clean_architecture/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean_architecture/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([NetworkInfo])
@GenerateMocks([
  NumberTriviaRemoteDataSource
], customMocks: [
  MockSpec<NumberTriviaRemoteDataSource>(
      as: #MockNumberTriviaDataSourceForTest, returnNullOnMissingStub: true),
])
class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NumberTriviaModel tNumberTriviaModel;
  late int tNumber;
  late NumberTriviaRepositoryImpl? repository;
  late MockRemoteDataSource? mockRemoteDataSource;
  late MockLocalDataSource? mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late NumberTrivia tNumberTrivia;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    tNumber = 1;
    tNumberTrivia = tNumberTriviaModel;
    tNumberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: tNumber);
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource!,
      localDataSource: mockLocalDataSource!,
      networkInfo: mockNetworkInfo,
    );
  });
  group('getConcreteNumberTrivia', () {
    test('should check if the device is online', () async {
      //arrange

      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      //act
      repository!.getConcreteNumberTrivia(tNumber);

      //assert
      verify(mockNetworkInfo.isConnected);
    });
  });
}
