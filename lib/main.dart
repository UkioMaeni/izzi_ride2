import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/localization_bloc/localization_bloc.dart';
import 'package:izzi_ride_2/core/bloc/registration_bloc/registration_bloc.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/factories/di_container.dart';
import 'package:izzi_ride_2/pages/auth_page/auth_page.dart';
import 'package:izzi_ride_2/pages/loader_page/loader_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';

void main() {
  setupGetIt();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
          BlocProvider(create: (context) => LocalizationBloc(),),
          BlocProvider(create: (context) => CreateRideBloc(),),
          BlocProvider(create: (context) => RegistrationBloc(),),
          BlocProvider(create: (context) => CarBloc(),),
          BlocProvider(create: (context) => CreateCarBloc(),),
          BlocProvider(create: (context) => RidesBloc(),),
        ],
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
