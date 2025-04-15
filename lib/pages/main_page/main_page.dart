import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/bloc/app_information_bloc/app_information_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/rides_bloc/rides_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/socket/app_socket.dart';
import 'package:izzi_ride_2/pages/main_page/components/tab_navigator.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/create_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/messages_tab/Messages_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/my_trips_tab/my_trips_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/profile_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/search_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  late final TabController _tabController;
  int page = 0;

  List<Widget> pages=[
    SearchTab(),
    MyTripsTab(),
    CreateTab(),
    MessagesTab(),
    ProfileTab()
  ];

  getMeInfo()async{
    context.read<UserMeBloc>().add(UserMeGetMeInfo());
  }

  connectToSocket(){
    
    appSocket.connect();
  }

  streamHandles(){
    appSocket.ridesTrigger.stream.listen(ridesTriggerStreamHandler);
  }

  ridesTriggerStreamHandler(int orderId){
    log("ridesTriggerStreamHandler");
    context.read<RidesBloc>().add(RidesUpdateRide(orderId: orderId));
  }

  initilizeRequiredServisez(){
    streamHandles();
    int initialTabPage= context.read<AppInformationBloc>().state.initialTabPage;
    log("INITIAL page");
    log(initialTabPage.toString());
    _tabController=TabController(initialIndex: 4, length: 5, vsync: this);

   bool isGetLoadedRequiredServices= context.read<AppInformationBloc>().state.isGetLoadedRequiredServices;
   if(isGetLoadedRequiredServices){
    connectToSocket();
   }
   
   getMeInfo();
  context.read<AppInformationBloc>().add(AppInformationSetRequridedLoadServices(isRequired: false));
  }


  @override
  void initState() {
  
    initilizeRequiredServisez();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        children: pages,
        controller: _tabController,
      ),
      bottomNavigationBar: TabNavigator(page:_tabController.index,tabController: _tabController,),
    );
  }
}