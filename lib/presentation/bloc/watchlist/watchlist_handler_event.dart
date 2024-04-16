sealed class WatchlistHandlerEvent {
  final int id;

  const WatchlistHandlerEvent(this.id);
}

class AddToWatchlist extends WatchlistHandlerEvent {
  const AddToWatchlist(super.id);
}

class RemoveFromWatchlist extends WatchlistHandlerEvent {
  const RemoveFromWatchlist(super.id);
}

class CheckWatchlistStatus extends WatchlistHandlerEvent {
  const CheckWatchlistStatus(super.id);
}
