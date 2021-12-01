enum Filter {
  all,
  searched,
}

extension FilterExtension on Filter {
  bool get isAll => this == Filter.all;
  bool get isSearched => this == Filter.searched;
}
