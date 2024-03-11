class TmdbApiConfig {
  static const String apiKey = "8f59944932f6a0798758c0f495b9c374";
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  static const String getRequestTokenEndpoint = "/authentication/token/new";
  static const String authenticationEndpoint = "/authentication/token/validate_with_login";
  static const String createSessionEndpoint = "/authentication/session/new";
  static const String deleteSession = "/authentication/session";

  static const String popularMoviesEndpoint = "/movie/popular";
  static const String trendingMoviesEndpoint = "/trending/movie/week";
  static const String topRatedMoviesEndpoint = "/movie/top_rated";
  static const String movieDetailEndpoint = "/movie/{{id}}";
  static const String watchListEndpoint = "/account/{{userId}}/watchlist/movies";
}