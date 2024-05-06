import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/injection_container.dart';
import 'package:movie_finder/presentation/bloc/search/search_bloc.dart';
import 'package:movie_finder/presentation/widgets/search/search_page_body.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (_) => serviceLocator<SearchBloc>(),
      child: const SearchPageBody(),
    );
  }
}
