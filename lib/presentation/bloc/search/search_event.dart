sealed class SearchEvent {
  const SearchEvent();
}

class SearchInput extends SearchEvent {
  final String input;

  SearchInput(this.input);
}