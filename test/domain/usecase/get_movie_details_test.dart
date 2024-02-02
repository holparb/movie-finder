import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/entities/genre.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/domain/usecases/get_movie_details.dart';

import 'usecase_test.mocks.dart';


void main() {
  late GetMovieDetailsUseCase usecase;
  late MockMovieRepository mockMovieRepository;

  Movie testMovieDetail = Movie(id: 1, title: "Movie", overview: "overview", posterPath: "posterPath",
      voteAverage: 1.0, backdropPath: "backdropPath", genreIds: [],
      genres: const [Genre(id: 1, name: "name"), Genre(id: 2, name: "name2")], releaseDate: DateTime.parse("1997-07-12"), runtime: 157);

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieDetailsUseCase(mockMovieRepository);
  });

  test("Should get movie details from the repository", () async  {
    // arrange
    when(mockMovieRepository.getMovieDetails(any)).thenAnswer((_) async => DataSuccess(testMovieDetail));
    // act
    final result = await usecase(params: testMovieDetail.id);
    // assert
    expect(result, DataSuccess(testMovieDetail));
  });

  test("Should return DataFailure if there was an error while getting the data", () async {
    // arrange
    DataError error = const DataError(message: "data error!");
    when(mockMovieRepository.getMovieDetails(any)).thenAnswer((_) async => DataFailure(error));
    // act
    final result = await usecase(params: testMovieDetail.id);
    // assert
    expect(result, isA<DataFailure>());
    expect(result.error, error);
  });
}