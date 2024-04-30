import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/core/data_state.dart';
import 'package:movie_finder/domain/usecases/search_movies.dart';
import 'package:movie_finder/presentation/bloc/search/search_event.dart';
import 'package:movie_finder/presentation/bloc/search/search_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCase _useCase;

  SearchBloc(this._useCase) : super(const SearchInitial()) {
    on <SearchInput> (onSearchInput,
        transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 600)).switchMap(mapper)
    );
  }

  void onSearchInput(SearchInput event, Emitter<SearchState> emit) async {
    emit(const SearchInProgress());
    final dataState = await _useCase(params: event.input);
    if(dataState is DataSuccess && dataState.data!.isEmpty) {
      emit(const SearchEmpty());
    }
    else if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(SearchResult(dataState.data!));
    }
    else if(dataState is DataFailure) {
      emit(SearchError(dataState.error!));
    }
  }
}