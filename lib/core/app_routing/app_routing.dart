import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';
import 'package:izzi_ride_2/pages/actions_ride_page/actions_ride_page.dart';
import 'package:izzi_ride_2/pages/actions_ride_page/actions_ride_page_done.dart';
import 'package:izzi_ride_2/pages/auth_page/auth_page.dart';
import 'package:izzi_ride_2/pages/autorize_phone_page/autorize_phone_page.dart';
import 'package:izzi_ride_2/pages/chat_page/chat_page.dart';
import 'package:izzi_ride_2/pages/code_phone_page/code_phone_page.dart';
import 'package:izzi_ride_2/pages/create_car_scenes/create_car_brand/create_car_brand.dart';
import 'package:izzi_ride_2/pages/create_car_scenes/create_car_color/create_car_color.dart';
import 'package:izzi_ride_2/pages/create_car_scenes/create_car_details/create_car_details.dart';
import 'package:izzi_ride_2/pages/create_car_scenes/create_car_model/create_car_model.dart';
import 'package:izzi_ride_2/pages/create_car_scenes/create_car_number/create_car_number.dart';
import 'package:izzi_ride_2/pages/create_car_scenes/create_car_photo/create_car_photo.dart';
import 'package:izzi_ride_2/pages/create_car_scenes/create_car_seats/create_car_seats.dart';
import 'package:izzi_ride_2/pages/create_car_scenes/create_car_year/create_car_year.dart';
import 'package:izzi_ride_2/pages/full_order_info/full_order_info.dart';
import 'package:izzi_ride_2/pages/initial_user_data_page/initial_user_data_page.dart';
import 'package:izzi_ride_2/pages/loader_page/loader_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';
import 'package:izzi_ride_2/pages/passport_photo_page/passport_photo_page.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_preview_scene.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_scene.dart';
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
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/calendare_scene/calendare_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/person_counter_scene/person_counter_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_from_input/search_from_input.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_from_map/search_from_map.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_result_scene/search_result_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_to_input/search_to_input.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_to_map/search_to_map.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/time_scene/time_scene.dart';
import 'package:izzi_ride_2/pages/payment_card_page/payment_card_page.dart';
import 'package:izzi_ride_2/pages/payment_process_page/payment_process_page.dart';

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
      
      //страница чата
      GoRoute(
        path: "/chat",
        name: RoutesName.chat,
        
        builder: (context, state)=>ChatPage(),
        //onExit: (_,__)=>false
      ),
      //страница просмотра полной информации ордера и манипуляцией с ним
      GoRoute(
        path: "/oder_full_info",
        name: RoutesName.orderFullInfo,
        
        builder: (context, state)=>FullOrderInfo(orderId: state.extra as int,),
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
          //Поиск флоу From
          GoRoute(
            path: "/search_from_input",
            name: RoutesName.searchFromInput,
            builder: (context, state)=>SearchFromInput(),
            routes: [
              GoRoute(
                path: "/search_from_map",
                name: RoutesName.searchFromMap,
                builder: (context, state)=>SearchFromMap(),
                routes: [
                  
                ]
              ),
            ]
          ),
          //Поиск флоу To
          GoRoute(
            path: "/search_to_input",
            name: RoutesName.searchToInput,
            builder: (context, state)=>SearchToInput(),
            routes: [
              GoRoute(
                path: "/search_to_map",
                name: RoutesName.searchToMap,
                builder: (context, state)=>SearchToMap(),
                routes: [
                  
                ]
              ),
            ]
          ),
          //Поиск флоу дата и время
          GoRoute(
            path: "/search_calendare",
            name: RoutesName.searchCalendare,
            builder: (context, state)=>SearchCalendareScene(),
            routes: [
              GoRoute(
                path: "/search_time",
                name: RoutesName.searchTime,
                builder: (context, state)=>SearchTimeScene(),
                routes: [
                  
                ]
              ),
            ]
          ),
          //Поиск колличества пассажиров
          GoRoute(
            path: "/search_counter",
            name: RoutesName.searchCounter,
            builder: (context, state)=>PersonCounterScene(),
            routes: []
          ),
          //Основной поиск результатов
          GoRoute(
            path: "/search_result",
            name: RoutesName.searchResult,
            builder: (context, state)=>SearchResultScene(),
            routes: []
          ),
          //флоу принятия заявок
          GoRoute(
            path: "/actions_ride_page",
            name: RoutesName.actionsRide,
            builder: (context, state)=>ActionsRidePage(),
            routes: [
              GoRoute(
                path: "/actions_ride_page_done",
                name: RoutesName.actionsRideDone,
                builder: (context, state)=>ActionsRidePageDone(),
                routes: []
              ),
            ]
          ),
          //флоу загрузки фото
          GoRoute(
            path: "/add_photo_page",
            name: RoutesName.addPhotoPage,
            builder: (context, state)=>PhotoScenePage(),
            routes: [
              GoRoute(
                path: "/add_photo_page_preview",
                name: RoutesName.addPhotoPagePreview,
                builder: (context, state)=>PhotoPreviewScene(),
                routes: []
              ),
            ]
          ),
          //флоу загрузки паспорта
          GoRoute(
            path: "/add_photo_passport_page",
            name: RoutesName.addPhotoPassportPage,
            builder: (context, state)=>PassportPhotoPage(),
            routes: []
          ),
          
          //флоу отображения карт пользателя
          GoRoute(
            path: "/payment_card",
            name: RoutesName.paymentCard,
            builder: (context, state)=>PaymentCardPage(),
            routes: [
            ]
          ),
          //флоу покупки
          GoRoute(
            path: "/payment_process",
            name: RoutesName.paymentProcess,
            builder: (context, state)=>PaymentProcessPage(),
            routes: [
            ]
          ),
          //Флоу создания машины
          GoRoute(
            path: "/create_car_brand",
            name: RoutesName.createCarBrand,
            builder: (context, state)=>CreateCarBrand(),
            routes: [
              GoRoute(
                path: "/create_car_model",
                name: RoutesName.createCarModel,
                builder: (context, state)=>CreateCarModel(),
                routes: [
                  GoRoute(
                    path: "/create_car_seats",
                    name: RoutesName.createCarSeats,
                    builder: (context, state)=>CreateCarSeats(),
                    routes: [
                      GoRoute(
                        path: "/create_car_color",
                        name: RoutesName.createCarColor,
                        builder: (context, state)=>CreateCarColor(),
                        routes: [
                          GoRoute(
                            path: "/create_car_number",
                            name: RoutesName.createCarNumber,
                            builder: (context, state)=>CreateCarNumber(),
                            routes: [
                              GoRoute(
                                path: "/create_car_year",
                                name: RoutesName.createCarYear,
                                builder: (context, state)=>CreateCarYear(),
                                routes: [
                                  GoRoute(
                                    path: "/create_car_photo",
                                    name: RoutesName.createCarPhoto,
                                    builder: (context, state)=>CreateCarPhoto(),
                                    routes: [
                                      GoRoute(
                                        path: "/create_car_details",
                                        name: RoutesName.createCarDetails,
                                        builder: (context, state)=>CreateCarDetails(),
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
  );


}


 class  RoutesName{
  //загрузочный экран приложения
  static String loader="loader";
  //главная страница авторизация с методами
  static String auth="auth";
  //авторизация разными методами
  static String authPhone="authPhone";
  static String authPhoneCode="authPhoneCode";
  static String authGoogle="authGoogle";
  static String authApple="authApple";
  //добавление отсутсвующих данных пользователя
  static String initialUserData="initialUserData";
  //главная страница с таб навигатором
  static String main="main";
  //создание поездки
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
  //поиск поездки
  static String searchFromInput="searchFromInput";
  static String searchFromMap="searchFromMap";
  static String searchToInput="searchToInput";
  static String searchToMap="searchToMap";
  static String searchCalendare="searchCalendare";
  static String searchTime="searchTime";
  static String searchCounter="searchCounter";
  static String searchResult="searchResult";
  //создание машины
  static String createCarBrand="createCarBrand";
  static String createCarModel="createCarModel";
  static String createCarSeats="createCarSeats";
  static String createCarColor="createCarColor";
  static String createCarNumber="createCarNumber";
  static String createCarYear="createCarYear";
  static String createCarPhoto="createCarPhoto";
  static String createCarDetails="createCarDetails";
  //полная информация ордера
  static String orderFullInfo="orderFullInfo";
  //сцены с фото и превью
  static String addPhotoPage="addPhotoPage";
  static String addPhotoPagePreview="addPhotoPagePreview";
  //сцена с фото паспорта
  static String addPhotoPassportPage="addPhotoPassportPage";
  //чат
  static String chat="chat";
  //сцены с флоу принятия заявок
  static String actionsRide="actionsRide";
  static String actionsRideDone="actionsRideDone";
  //сцена отображения кард
  static String paymentCard="paymentCard";
  //сцена процесса покупки
  static String paymentProcess="paymentProcess";

}