class SearchQueryModel {
  const SearchQueryModel(this.value);

  final String value;

  String get normalized => value.trim();
}
