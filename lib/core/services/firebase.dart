import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:permission_handler/permission_handler.dart';


@pragma('vm:entry-point')
Future<void> _bgHandler(RemoteMessage msg) async {
  // Инициализируем плагин, если нужно
  print("_bgHandler");
  await Firebase.initializeApp();
  const platform = MethodChannel('flutter_bg_location_plugin');
    await platform.invokeMethod('LOCATION_SERVICE_START', {
      'seconds': 30,
      'hash': msg.data['hash'] ?? '',
      'orderId': msg.data['orderId'] ?? '',
    });
  // if (msg.data['action'] == 'track_location') {
  //   // дергаем ваш method-channel для старта локации
    
  // }
}

class FirebaseDriver{


  init()async{
    await requestPermission();
    String? token = await FirebaseMessaging.instance.getToken();
    print("SSSS"+token.toString());
    if(token!=null){
      await UserHttp.I.setFcmToken(token);
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    inspect(message);
    
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
    });
    FirebaseMessaging.onBackgroundMessage(_bgHandler);
    // final apnsToken = await FirebaseMessaging.instance.getToken();
    // print("FB");
    // print(apnsToken);
    // if(apnsToken!=null){
    //   String platform="";
    //   if(Platform.isAndroid){
    //     platform="android";
    //   }
    //   if(Platform.isIOS){
    //     platform="ios";
    //   }
    //   await HttpToken().pushToken(platform, apnsToken);
    // }
  }

  Future<void> requestPermission()async{
    // await Permission.locationAlways.request();
    // await FirebaseMessaging.instance.requestPermission();
    final perm = await Permission.locationWhenInUse.request();
    print('requestPermission');
    print(perm.isGranted.toString());
    if (perm.isGranted) {
      // покажем вторую просьбу через тот же пакет
      final always = await Permission.locationAlways.request();
      if (always.isGranted) {
        print('✅ Always granted');
      }
    }
  }


}