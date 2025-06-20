import 'dart:developer';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/app_information_bloc/app_information_bloc.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/chats_bloc/chats_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc/create_car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/localization_bloc/localization_bloc.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/bloc/registration_bloc/registration_bloc.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/factories/di_container.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:izzi_ride_2/core/services/background_locator_service.dart';
import 'package:izzi_ride_2/core/services/deep_link_service.dart';
import 'package:izzi_ride_2/firebase_options.dart';
import 'package:izzi_ride_2/pages/actions_ride_page/actions_ride_provider/actions_ride_provider.dart';
import 'package:izzi_ride_2/pages/auth_page/auth_page.dart';
import 'package:izzi_ride_2/pages/loader_page/loader_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_background_service_android/flutter_background_service_android.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // bool isRunning = await  FlutterBackgroundService().isRunning();
  // print(isRunning.toString());
  // if(!isRunning){
  //   await FlutterBackgroundService().configure(
    
  //   androidConfiguration: AndroidConfiguration(
  //     onStart: onStart,
  //     autoStart: false,                       // ← не запускать сразу
  //     foregroundServiceTypes: [AndroidForegroundType.location],
  //     initialNotificationTitle: 'Готов к трекингу',
  //     initialNotificationContent:  'GPS в ожидании',
  //     isForegroundMode: true,

  //   ), 
  //   iosConfiguration: IosConfiguration(
      
  //     onForeground: onStart,
  //     autoStart: false,
  //   ),
  // );
  // }
  //await _initializeNotificationChannel();
  setupGetIt();
  Stripe.publishableKey = "pk_test_51Q5iTY06u8jzHB84AlAlgWsw5h51Jx2bhOOeKYst3pTqQDwvVkLNPMJhazINw9XNoj5Fm1lqL7Uw8USwr9I5QL3B00X6MHrqAb";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  
  runApp(
    MultiBlocProvider(
      providers: [
          BlocProvider(create: (context) => LocalizationBloc(),),
          BlocProvider(create: (context) => CreateRideBloc(),),
          BlocProvider(create: (context) => RegistrationBloc(),),
          BlocProvider(create: (context) => CarBloc(),),
          BlocProvider(create: (context) => CreateCarBloc(),),
          BlocProvider(create: (context) => RidesBloc(),),
          BlocProvider(create: (context) => UserMeBloc(),),
          BlocProvider(create: (context) => SearchRideBloc(),),
          BlocProvider(create: (context) => ChatsBloc(),),
          BlocProvider(create: (context) => PhotoAddBloc(),),
          BlocProvider(create: (context) => AppInformationBloc(),),
        ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => chatProvider,
          ),
          ChangeNotifierProvider(
            create: (context) => actionsRideProvider,
          ),
        ],
        child: MyApp()
      )
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  
  @override
  void initState() {
    super.initState();
    deepLinkService.init();
    // при запуске (когда приложение закрыто)
    
  }

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const LoaderPage()
    // );
    return MaterialApp.router(
      routerConfig: AppRoiting.router,
      
      title: 'Flutter Demo',
    );
  }
}



