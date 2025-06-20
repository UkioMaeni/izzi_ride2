import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/tab_header.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/app_information_bloc/app_information_bloc.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc/create_car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/bloc/registration_bloc/registration_bloc.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/settings_title_model.dart';
import 'package:izzi_ride_2/core/providers/chat_provider.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/socket/app_socket.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/profile_tab.dart';
import 'package:izzi_ride_2/pages/settings_page/components/settings_title.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  bool logOutProcess = false;

  Future<void> logOut()async{
    if(logOutProcess){
      return;
    }
    logOutProcess=true;
    await appSocket.disconnect();
    chatProvider.RESET_DATA();
    context.read<UserMeBloc>().add(const UserMe_RESET_DATA());
    context.read<CarBloc>().add(const Car_RESET_DATA());
    context.read<CreateCarBloc>().add(const CreateCar_RESET_DATA());
    context.read<CreateRideBloc>().add(const CreateRide_RESET_DATA());
    context.read<PhotoAddBloc>().add(const PhotoAdd_RESET_DATA());
    context.read<RegistrationBloc>().add(const Registration_RESET_DATA());
    context.read<RidesBloc>().add(const Rides_RESET_DATA());
    context.read<SearchRideBloc>().add(const SearchRide_RESET_DATA());
    context.read<AppInformationBloc>().add(const AppInformation_RESET_DATA());
    await GetIt.I.get<TokenInterface>().deleteAccessToken();
    await GetIt.I.get<TokenInterface>().deleteRefreshToken();
    context.goNamed(RoutesName.loader);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColor.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: BrandColor.white,
        surfaceTintColor: BrandColor.white,
      ),
      body: Column(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 36),
                height: 50,
                alignment: Alignment.centerLeft,
                child: R.SVG.NavigationBackIcon,
              ),
          ),
          SizedBox(height: 54,),
          UITabHeader(label: "Settings",leftPadding: 24,),
          SizedBox(height: 23,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Divider(),
                    // SettingsTitle(
                    //   padding: EdgeInsets.symmetric(vertical: 24),
                    //   settingsTitleModel: SettingsTitleModel(
                    //     title: "Account Settings",
                    //     punkts: [
                    //       SettingPunktAction(title: "Password", subTitle: "Change your password"),
                    //       SettingPunktAction(title: "Payment Methods", subTitle: "Manage your payment options"),
                    //     ]
                    //   ),
                    // ),
                    // Divider(),
                    // SettingsTitle(
                    //   padding: EdgeInsets.symmetric(vertical: 24),
                    //   settingsTitleModel: SettingsTitleModel(
                    //     title: "Preferences",
                    //     punkts: [
                    //       SettingPunktAction(title: "Notifications", subTitle: "Customize your notification preferences"),
                    //       SettingPunktAction(title: "Theme", subTitle: "Dark mode, Light mode, System default"),
                    //     ]
                    //   ),
                    // ),
                    Divider(),
                    SettingsTitle(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      settingsTitleModel: SettingsTitleModel(
                        title: "Support",
                        punkts: [
                          SettingPunktAction(title: "Help Center", subTitle: "Access FAQs and support articles"),
                          SettingPunktAction(title: "Contact Us", subTitle: "Get in touch with our support team"),
                          SettingPunktAction(title: "Privacy Policy", subTitle: "Read our privacy policy"),
                          SettingPunktAction(title: "Terms of Service", subTitle: "View our terms of service"),
                        ]
                      ),
                    ),
                    Divider(),
                    SettingsTitle(
                      padding: EdgeInsets.only(top: 24),
                      settingsTitleModel: SettingsTitleModel(
                        title: "Log out",
                      ),
                    ),
                    SizedBox(height: 32,),
                    UIButton(
                      label: "Log out",
                      onFuture: logOut,
                    ),
                    SizedBox(height: 0,),
                    
                    UIButton(
                      label: "Delete account",
                      alternate: true,
                      backgroundColor: Colors.transparent,
                      textColor: BrandColor.red193,
                      onFuture: logOut,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}