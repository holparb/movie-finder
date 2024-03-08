import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/get_movie_details.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_event.dart';
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_state.dart';

import '../../../helper/test_data.dart';
import 'movie_details_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetailsUseCase])
void main() {

  late MockGetMovieDetailsUseCase usecase;
  late MovieDetailsBloc movieDetailsBloc;

  setUp(() {
    usecase = MockGetMovieDetailsUseCase();
    movieDetailsBloc = MovieDetailsBloc(usecase);
  });

  test("Initial state should be MovieDetailsLoading", () {
    expect(movieDetailsBloc.state, const MovieDetailsLoading());
  });

  group("GetMovieDetails", () {
    blocTest<MovieDetailsBloc, MovieDetailsState>("Should return MovieDetailsLoaded with valid movies list if DataSuccess is returned from usecase",
        build: () {
          when(usecase(params: testMovieDetail.id)).thenAnswer((_) async => DataSuccess(testMovieDetail));
          return movieDetailsBloc;
        },
        act: (bloc) => bloc.add(GetMovieDetails(id: testMovieDetail.id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const MovieDetailsLoading(),
          MovieDetailsLoaded(testMovieDetail)
        ]
    );
    DataError error = const DataError(message: "Data fetch failed!");
    blocTest<MovieDetailsBloc, MovieDetailsState>("Should return MovieDetailsError if DataFailure is returned from usecase",
        build: () {
          when(usecase(params: testMovieDetail.id)).thenAnswer((_) async => DataFailure(error));
          return movieDetailsBloc;
        },
        act: (bloc) => bloc.add(GetMovieDetails(id: testMovieDetail.id)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const MovieDetailsLoading(),
          MovieDetailsError(error)
        ]
    );
  });
}