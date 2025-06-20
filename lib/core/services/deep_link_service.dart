import 'package:app_links/app_links.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';

class DeepLinkService {

  final _appLinks = AppLinks();

  Uri? link; 

  init(){
    _appLinks.getInitialLink().then((uri) {
      if (uri != null) {
        print("📦 Initial deep link: $uri");
        link=uri;
        //AppRoiting.router.go(uri.path);
      }
    });

    // когда приложение в фоне или открыто
    _appLinks.uriLinkStream.listen((uri) {
      if (uri != null) {
        print("📥 Deep link while running: $uri");
        AppRoiting.router.push(uri.path);
      }
    });
  }
}

DeepLinkService deepLinkService = DeepLinkService();