import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/pages/auth_page/auth_page.dart';
import 'package:izzi_ride_2/pages/autorize_phone_page/autorize_phone_page.dart';
import 'package:izzi_ride_2/pages/code_phone_page/code_phone_page.dart';
import 'package:izzi_ride_2/pages/initial_user_data_page/initial_user_data_page.dart';
import 'package:izzi_ride_2/pages/loader_page/loader_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/additional_options_scene/additional_options_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/calendare_scene/calendare_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/create_done/create_done.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/from_input_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/from_map_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/instant_booking_scene/instant_booking_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/payment_scene/payment_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/preview_create/preview_create.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/price_scene/price_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/select_car_scene/select_car_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/time_scene/time_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/to_input_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/to_map_scene.dart';

class AppRoiting{

  static GoRouter  router = GoRouter(
    initialLocation: "/loader",
    errorBuilder: (context, state) {
      print("errror");
      return SizedBox.shrink();
    },
    routes: [
      GoRoute(
        path: "/loader",
        name: RoutesName.loader,
        
        builder: (context, state)=>LoaderPage(),
        //onExit: (_,__)=>false
      ),
      GoRoute(
        path: "/auth",
        name: RoutesName.auth,
        builder: (context, state)=>AuthPage(),
        routes: [
          GoRoute(
            path: "/auth_phone",
            name: RoutesName.authPhone,
            builder: (context, state)=>AutorizePhonePage(),
            routes: [
              GoRoute(
                path: "/code_phone",
                name: RoutesName.authPhoneCode,
                builder: (context, state)=>CodePhonePage(),
                routes: [

                ]
              ),
            ]
          ),
          GoRoute(
            path: "/auth_google",
            name: RoutesName.authGoogle,
            builder: (context, state)=>AutorizePhonePage()
          ),
          GoRoute(
            path: "/auth_apple",
            name: RoutesName.authApple,
            builder: (context, state)=>AutorizePhonePage()
          ),
        ]
      ),
      GoRoute(
        path: "/init_user_data",
        name: RoutesName.initialUserData,
        builder: (context, state)=>InitialUserDataPage(),
        onExit: (_,__)=>false
      ),
      GoRoute(
        path: "/main",
        name: RoutesName.main,
        builder: (context, state)=>MainPage(),
        onExit: (_,__){
          print("back");
          return true;
        },
        routes: [
          GoRoute(
            path: "/create_from_input",
            name: RoutesName.createFromInput,
            builder: (context, state)=>FromInputScene(),
            routes: [
              GoRoute(
                path: "/create_from_map",
                name: RoutesName.createFromMap,
                builder: (context, state)=>FromMapScene(),
                routes: [
                  GoRoute(
                    path: "/create_to_input",
                    name: RoutesName.createToInput,
                    builder: (context, state)=>ToInputScene(),
                    routes: [
                      GoRoute(
                        path: "/create_to_map",
                        name: RoutesName.createToMap,
                        builder: (context, state)=>ToMapScene(),
                        routes: [
                          GoRoute(
                            path: "/create_calendare",
                            name: RoutesName.createCalendare,
                            builder: (context, state)=>CalendareScene(),
                            routes: [
                              GoRoute(
                                path: "/create_time",
                                name: RoutesName.createTime,
                                builder: (context, state)=>TimeScene(),
                                routes: [
                                  GoRoute(
                                    path: "/create_car",
                                    name: RoutesName.createCar,
                                    builder: (context, state)=>SelectCarScene(),
                                    routes: [
                                      GoRoute(
                                        path: "/create_additional",
                                        name: RoutesName.createAdditional,
                                        builder: (context, state)=>AdditionalOptionsScene(),
                                        routes: [
                                          GoRoute(
                                            path: "/create_price",
                                            name: RoutesName.createPrice,
                                            builder: (context, state)=>PriceScene(),
                                            routes: [
                                              GoRoute(
                                                path: "/create_payment",
                                                name: RoutesName.payment,
                                                builder: (context, state)=>PaymentScene(),
                                                routes: [
                                                  GoRoute(
                                                    path: "/create_instant",
                                                    name: RoutesName.createInstant,
                                                    builder: (context, state)=>InstantBookingScene(),
                                                    routes: [
                                                      GoRoute(
                                                        path: "/create_preview",
                                                        name: RoutesName.createPreview,
                                                        builder: (context, state)=>PreviewCreate(),
                                                        routes: [
                                                          GoRoute(
                                                            path: "/create_done",
                                                            name: RoutesName.createDone,
                                                            builder: (context, state)=>CreateDone(),
                                                            routes: [
                                                              
                                                            ]
                                                          ),
                                                        ]
                                                      ),
                                                    ]
                                                  ),
                                                  
                                                ]
                                              ),
                                            ]
                                          ),
                                        ]
                                      ),
                                    ]
                                  ),
                                ]
                              ),
                            ]
                          ),
                        ]
                      ),
                    ]
                  ),
                ]
              ),
            ]
          ),
        ]
      ),
    ]
  );


}


 class  RoutesName{
  static String loader="loader";
  static String auth="auth";
  static String authPhone="authPhone";
  static String authPhoneCode="authPhoneCode";
  static String authGoogle="authGoogle";
  static String authApple="authApple";
  static String initialUserData="initialUserData";
  static String main="main";
  static String createFromInput="createFromInput";
  static String createFromMap="createFromMap";
  static String createCalendare="createCalendare";
  static String createTime="createTime";
  static String createToInput="createToInput";
  static String createToMap="createToMap";
  static String createCar="createCar";
  static String createAdditional="createAdditional";
  static String createPrice="createPrice";
  static String payment="payment";
  static String createInstant="createInstant";
  static String createPreview="createPreview";
  static String createDone="createDone";
}