enum LoadedBy {
  id,
  query,
  none,
}

extension LoadedByExtension on LoadedBy {
  bool get isLoadedById => this == LoadedBy.id;
  bool get isLoadedByQuery => this == LoadedBy.query;
  bool get isLoadedByNone => this == LoadedBy.none;
}
