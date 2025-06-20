// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:geolocator/geolocator.dart';



// StreamSubscription<Position>? _sub;
// @pragma('vm:entry-point')
// void onStart(ServiceInstance service) async {
//   final AndroidServiceInstance? android =
//       service is AndroidServiceInstance ? service : null;
//   // ——— команды из главного изолята ———
//   service.on('startTracking').listen((_) async {
//     if (_sub != null) return;                         

//     android?.setForegroundNotificationInfo(
//       title: 'GPS активен',
//       content: 'Отправляем координаты каждые 5 с',
//     );

//     var settings = LocationSettings(
//       accuracy: LocationAccuracy.bestForNavigation,
//       distanceFilter: 0,
//       timeLimit: Duration(seconds: 5),
//     );
//     if (Platform.isAndroid) {
//       settings = AndroidSettings(
//         accuracy: LocationAccuracy.high, 
//         distanceFilter: 1,
//         foregroundNotificationConfig: const ForegroundNotificationConfig(
//           notificationText:
//               "XYZ App will continue to receive your location even when you aren't using it",
//           notificationTitle: "Running in Background",
//           enableWakeLock: true,
//         ),
//       );
//     }
//     _sub = Geolocator.getPositionStream(locationSettings: settings)
//         .listen((pos) async {
//           log("Geolocator");
//           log(pos.altitude.toString());
//       // await http.post(
//       //   Uri.parse('https://api.example.com/locations'),
//       //   headers: {'Content-Type': 'application/json'},
//       //   body: {
//       //     'lat': pos.latitude,
//       //     'lon': pos.longitude,
//       //     'speed': pos.speed,
//       //     'ts': DateTime.now().toIso8601String(),
//       //   },
//       // );
//     });
//   });

//   service.on('stopTracking').listen((_) async {
//     await _sub?.cancel();
//     _sub = null;

//     android?.setForegroundNotificationInfo(
//       title: 'GPS выключен',
//       content: 'Трекинг приостановлен',
//     );

//     // Можно остановить сервис полностью, если больше не нужен:
//     // service.stopSelf();
//   });
// }
