sealed class WatchlistEvent {
  const WatchlistEvent();
}

class GetWatchlist extends WatchlistEvent {
  const GetWatchlist();
}

class IsMovieOnWatchlist extends WatchlistEvent {
  final int id;

  const IsMovieOnWatchlist(this.id);
}