
class MapParams{
  String placeId;
  double lon;
  double lat;
  String description;
  MapParams({
    required this.placeId,
    required this.lon,
    required this.lat,
    required this.description,
  });

  static MapParams empty(){
    return MapParams(placeId: "", lon: 0, lat: 0, description: "");
  }
}