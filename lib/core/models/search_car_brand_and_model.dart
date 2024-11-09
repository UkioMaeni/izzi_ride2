class SearchCarBrandAndModel{
  int id;
  String name;
  SearchCarBrandAndModel({
    required this.id,
    required this.name,
  });
  static SearchCarBrandAndModel empty()=>SearchCarBrandAndModel(id: 0,name: "");
}