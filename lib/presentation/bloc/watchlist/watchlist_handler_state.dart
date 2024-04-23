sealed class WatchlistHandlerState {
  const WatchlistHandlerState();
}

class OnWatchlist extends WatchlistHandlerState {
  const OnWatchlist();
}

class NotOnWatchlist extends WatchlistHandlerState {
  const NotOnWatchlist();
}

class WatchlistHandlerError extends WatchlistHandlerState {
  const WatchlistHandlerError();
}