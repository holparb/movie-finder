String formatString(String string, List<String> args) {
  /// default regex
  const String placeholderPattern = r'(\{\{([a-zA-Z0-9]+)\}\})';

  var regExp = RegExp(placeholderPattern);
  assert(regExp.allMatches(string).length == args.length,
  "String template and arguments length are incompatible");

  for (var replacement in args) {
    string = string.replaceFirst(regExp, replacement.toString());
  }

  return string;
}