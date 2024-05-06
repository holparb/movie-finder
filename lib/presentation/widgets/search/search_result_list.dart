import 'package:flutter/material.dart';
import 'package:movie_finder/domain/entities/movie.dart';
import 'package:movie_finder/presentation/widgets/home_page/movie_list_item.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({super.key, required this.searchResult});
  
  final List<Movie> searchResult;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: searchResult.length,
      itemBuilder: (context, index) => MovieListItem(movie: searchResult[index]),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisExtent: 280,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8
      ),
    );
  }
}
