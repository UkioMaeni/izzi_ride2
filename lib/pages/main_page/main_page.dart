import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/pages/main_page/components/tab_navigator.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/create_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/my_trips_tab/my_trips_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/profile_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/search_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  late final PageController _pageController;
  late final TabController _tabController;
  int page = 0;

  List<Widget> pages=[
    SearchTab(),
    MyTripsTab(),
    CreateTab(),
    SizedBox(),
    ProfileTab()
  ];

  getMeInfo()async{
    context.read<UserMeBloc>().add(UserMeGetMeInfo());
  }

  @override
  void initState() {
    _pageController=PageController(initialPage:page );
    _tabController=TabController(length: 5, vsync: this);
    getMeInfo();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
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