import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/presentation/bloc/search/search_bloc.dart';
import 'package:movie_finder/presentation/bloc/search/search_event.dart';
import 'package:movie_finder/presentation/bloc/search/search_state.dart';
import 'package:movie_finder/presentation/widgets/common/empty_list.dart';
import 'package:movie_finder/presentation/widgets/common/list_error.dart';
import 'package:movie_finder/presentation/widgets/search/search_result_list.dart';

class SearchPageBody extends StatelessWidget {
  const SearchPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            onChanged: (text) {
              BlocProvider.of<SearchBloc>(context).add(SearchInput(text));
            },
            decoration: InputDecoration(
              hintText: "Search movies",
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white70,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<SearchBloc, SearchState>(
              buildWhen: (previous, current) => current != previous,
              builder: (_, state) {
                return switch (state) {
                  SearchEmpty() => const EmptyList(text: "No results"),
                  SearchInProgress() => const Center(child: CircularProgressIndicator()),
                  SearchResult searchResult => SearchResultList(searchResult: searchResult.results),
                  SearchError() => const ListError(text: "Couldn't load search result, check your connection and try again!"),
                  SearchInitial() => const SizedBox(),
                };
              }
            ),
          )
        ],
      ),
    );
  }
}
