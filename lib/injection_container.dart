import 'package:get_it/get_it.dart';
import 'package:movie_finder/core/network_info.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/auth_data_source.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/repositories/auth_repository.dart';
import 'package:movie_finder/data/repositories/movie_repository.dart';
import 'package:movie_finder/domain/repositories/auth_repository.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';
import 'package:movie_finder/domain/usecases/get_movie_details.dart';
import 'package:movie_finder/domain/usecases/get_popular_movies.dart';
import 'package:movie_finder/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_finder/domain/usecases/is_user_logged_in.dart';
import 'package:movie_finder/domain/usecases/login.dart';
import 'package:movie_finder/domain/usecases/logout.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/top_rated_movies_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/router/app_router.dart';

final serviceLocator = GetIt.I;

Future<void> initializeDependencies() async {
  // router
  serviceLocator.registerSingleton<AppRouter>(AppRouter());

  // network util
  serviceLocator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplementation());
  serviceLocator.registerLazySingleton<http.Client>(() => http.Client());

  // data sources
  serviceLocator.registerSingleton<MoviesDataSource>(MoviesDataSource(serviceLocator()));
  serviceLocator.registerSingleton<AuthDataSource>(AuthDataSource(serviceLocator()));
  serviceLocator.registerSingleton<LocalUserDataSource>(const LocalUserDataSource());

  // repositories
  serviceLocator.registerSingleton<MovieRepository>(MovieRepositoryImpl(serviceLocator()));
  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl(serviceLocator(), serviceLocator()));

  // usecases
  serviceLocator.registerSingleton<GetTopRatedMoviesUseCase>(GetTopRatedMoviesUseCase(serviceLocator()));
  serviceLocator.registerSingleton<GetMovieDetailsUseCase>(GetMovieDetailsUseCase(serviceLocator()));
  serviceLocator.registerSingleton<GetPopularMoviesUseCase>(GetPopularMoviesUseCase(serviceLocator()));
  serviceLocator.registerSingleton<LoginUsecase>(LoginUsecase(serviceLocator()));
  serviceLocator.registerSingleton<LogoutUsecase>(LogoutUsecase(serviceLocator()));
  serviceLocator.registerSingleton<IsUserLoggedInUseCase>(IsUserLoggedInUseCase(serviceLocator()));

  // blocs
  serviceLocator.registerFactory<TopRatedMoviesBloc>(() => TopRatedMoviesBloc(serviceLocator()));
  serviceLocator.registerFactory<PopularMoviesBloc>(() => PopularMoviesBloc(serviceLocator()));
  serviceLocator.registerFactory<MovieDetailsBloc>(() => MovieDetailsBloc(serviceLocator()));
  serviceLocator.registerFactory<AuthBloc>(() => AuthBloc(serviceLocator(), serviceLocator(), serviceLocator()));
}