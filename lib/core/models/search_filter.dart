class SearchFilter{
  ECategory category;
  String value;
  SearchFilter({
    required this.category,
    required this.value
  });
}

enum ECategory{
  Sort
}