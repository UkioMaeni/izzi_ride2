import 'package:googlemaps_flutter_webservices/places.dart';

class AppConfig{
  static String requestUrl = "http://194.135.105.117:8090/api/v1";
  static String photoUrl = "http://194.135.105.117:8090/api/v1/download?filename=";
  static final places = GoogleMapsPlaces(apiKey: 'AIzaSyDQ2a3xgarJk8qlNGzNCLzrH3H_XmGSUaY');
}