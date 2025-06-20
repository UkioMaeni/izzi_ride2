import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';

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
    await FirebaseMessaging.instance.requestPermission();
  }


}