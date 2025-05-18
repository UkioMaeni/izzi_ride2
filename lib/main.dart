import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/app_information_bloc/app_information_bloc.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/chats_bloc/chats_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/localization_bloc/localization_bloc.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/bloc/registration_bloc/registration_bloc.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/factories/di_container.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:izzi_ride_2/pages/actions_ride_page/actions_ride_provider/actions_ride_provider.dart';
import 'package:izzi_ride_2/pages/auth_page/auth_page.dart';
import 'package:izzi_ride_2/pages/loader_page/loader_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
