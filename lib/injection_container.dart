import 'package:get_it/get_it.dart';
import 'package:movie_finder/core/utils/network_info.dart';
import 'package:movie_finder/data/datasources/local/local_movies_datasource.dart';
import 'package:movie_finder/data/datasources/local/local_user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/user_data_source.dart';
import 'package:movie_finder/data/datasources/remote/movies_data_source.dart';
import 'package:movie_finder/data/repositories/user_repository.dart';
import 'package:movie_finder/data/repositories/movie_repository.dart';
import 'package:movie_finder/domain/repositories/user_repository.dart';
import 'package:movie_finder/domain/repositories/movie_repository.dart';
import 'package:movie_finder/domain/usecases/add_to_watchlist.dart';
import 'package:movie_finder/domain/usecases/get_movie_details.dart';
import 'package:movie_finder/domain/usecases/get_popular_movies.dart';
import 'package:movie_finder/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_finder/domain/usecases/get_watchlist.dart';
import 'package:movie_finder/domain/usecases/is_movie_on_watchlist.dart';
import 'package:movie_finder/domain/usecases/is_user_logged_in.dart';
import 'package:movie_finder/domain/usecases/login.dart';
import 'package:movie_finder/domain/usecases/logout.dart';
import 'package:movie_finder/domain/usecases/remove_from_watchlist.dart';
import 'package:movie_finder/domain/usecases/search_movies.dart';
import 'package:movie_finder/presentation/bloc/auth/auth_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/popular_movies_bloc.dart';
import 'package:movie_finder/presentation/bloc/movies/top_rated_movies_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_finder/presentation/bloc/movie_details/movie_details_bloc.dart';
import 'package:movie_finder/presentation/bloc/search/search_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_handler_bloc.dart';
import 'package:movie_finder/presentation/bloc/watchlist/watchlist_loader_bloc.dart';
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
  serviceLocator.registerSingleton<UserDataSource>(UserDataSource(serviceLocator()));
  serviceLocator.registerSingleton<LocalUserDataSource>(const LocalUserDataSource());
  serviceLocator.registerSingleton<LocalMoviesDataSource>(const LocalMoviesDataSource());

  // repositories
  serviceLocator.registerSingleton<MovieRepository>(MovieRepositoryImpl(serviceLocator(), serviceLocator(), serviceLocator()));
  serviceLocator.registerSingleton<UserRepository>(UserRepositoryImpl(serviceLocator(), serviceLocator()));

  // usecases
  serviceLocator.registerSingleton<GetTopRatedMoviesUseCase>(GetTopRatedMoviesUseCase(serviceLocator()));
  serviceLocator.registerSingleton<GetMovieDetailsUseCase>(GetMovieDetailsUseCase(serviceLocator()));
  serviceLocator.registerSingleton<GetPopularMoviesUseCase>(GetPopularMoviesUseCase(serviceLocator()));
  serviceLocator.registerSingleton<LoginUsecase>(LoginUsecase(serviceLocator()));
  serviceLocator.registerSingleton<LogoutUsecase>(LogoutUsecase(serviceLocator()));
  serviceLocator.registerSingleton<IsUserLoggedInUseCase>(IsUserLoggedInUseCase(serviceLocator()));
  serviceLocator.registerSingleton<GetWatchlistUseCase>(GetWatchlistUseCase(serviceLocator()));
  serviceLocator.registerSingleton<IsMovieOnWatchlistUseCase>(IsMovieOnWatchlistUseCase(serviceLocator()));
  serviceLocator.registerSingleton<AddToWatchlistUseCase>(AddToWatchlistUseCase(serviceLocator()));
  serviceLocator.registerSingleton<RemoveFromWatchlistUseCase>(RemoveFromWatchlistUseCase(serviceLocator()));
  serviceLocator.registerSingleton<SearchMoviesUseCase>(SearchMoviesUseCase(serviceLocator()));

  // blocs
  serviceLocator.registerFactory<TopRatedMoviesBloc>(() => TopRatedMoviesBloc(serviceLocator()));
  serviceLocator.registerFactory<PopularMoviesBloc>(() => PopularMoviesBloc(serviceLocator()));
  serviceLocator.registerFactory<MovieDetailsBloc>(() => MovieDetailsBloc(serviceLocator()));
  serviceLocator.registerFactory<AuthBloc>(() => AuthBloc(serviceLocator(), serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory<WatchlistLoaderBloc>(() => WatchlistLoaderBloc(serviceLocator()));
  serviceLocator.registerFactory<WatchlistHandlerBloc>(() => WatchlistHandlerBloc(serviceLocator(), serviceLocator(), serviceLocator()));
  serviceLocator.registerFactory<SearchBloc>(() => SearchBloc(serviceLocator()));
}