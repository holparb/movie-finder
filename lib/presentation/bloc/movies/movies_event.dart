sealed class MoviesEvent {
  const MoviesEvent();
}

class GetTrendingMovies extends MoviesEvent {
  const GetTrendingMovies();
}

class GetPopularMovies extends MoviesEvent {
  const GetPopularMovies();
}