import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/core/exceptions/data_error.dart';
import 'package:movie_finder/domain/usecases/search_movies.dart';
import 'package:movie_finder/presentation/bloc/search/search_bloc.dart';
import 'package:movie_finder/presentation/bloc/search/search_event.dart';
import 'package:movie_finder/presentation/bloc/search/search_state.dart';

import '../../../helper/test_data.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMoviesUseCase])
void main() {

  late MockSearchMoviesUseCase useCase;
  late SearchBloc bloc;

  setUp(() {
    useCase = MockSearchMoviesUseCase();
    bloc = SearchBloc(useCase);
  });

  test("Initial state should be SearchEmpty", () {
    expect(bloc.state, const SearchEmpty());
  });

  group("Search", () {
    const String query = "text";
    blocTest<SearchBloc, SearchState>("Should return  with valid movies list if DataSuccess is returned from use case",
        build: () {
          when(useCase(params: query)).thenAnswer((_) async => const DataSuccess(testMovies));
          return bloc;
        },
        act: (bloc) {
            bloc.add(SearchInput(query));
          },
        wait: const Duration(seconds: 1),
        expect: () => [
          const SearchInProgress(),
          const SearchResult(testMovies)
        ]
    );
    DataError error = const DataError(message: "Data fetch failed!");
    blocTest<SearchBloc, SearchState>("Should return SearchError if DataFailure is returned from use case",
        build: () {
          when(useCase(params: query)).thenAnswer((_) async => DataFailure(error));
          return bloc;
        },
        act: (bloc) => bloc.add(SearchInput(query)),
        wait: const Duration(seconds: 1),
        expect: () => [
          const SearchInProgress(),
          SearchError(error)
        ]
    );
  });
}