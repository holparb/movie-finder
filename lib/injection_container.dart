import 'package:get_it/get_it.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/repositories/movie_repository.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';
import 'package:movie_finder/domain/usecases/get_movie_details.dart';
import 'package:movie_finder/domain/usecases/get_trending_movies.dart';
import 'package:movie_finder/presentation/bloc/movie/trending_movies_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/router/app_router.dart';

final serviceLocator = GetIt.I;

Future<void> initializeDependencies() async {
  // router
  serviceLocator.registerSingleton<AppRouter>(AppRouter());

  // network util
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  // data sources
  serviceLocator.registerSingleton<MoviesDataSource>(MoviesDataSource(serviceLocator()));

  // repositories
  serviceLocator.registerSingleton<MovieRepository>(MovieRepositoryImplementation(serviceLocator()));

  // usecases
  serviceLocator.registerSingleton<GetTrendingMoviesUseCase>(GetTrendingMoviesUseCase(serviceLocator()));
  serviceLocator.registerSingleton<GetMovieDetailsUseCase>(GetMovieDetailsUseCase(serviceLocator()));

  // blocs
  serviceLocator.registerFactory<MoviesBloc>(() => MoviesBloc(serviceLocator()));
  serviceLocator.registerFactory<MovieDetailsBloc>(() => MovieDetailsBloc(serviceLocator()));
}