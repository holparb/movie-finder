
sealed class MovieDetailsEvent {
  const MovieDetailsEvent();
}

class GetMovieDetails extends MovieDetailsEvent {
  final int id;
  const GetMovieDetails({required this.id});
}