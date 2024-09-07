import 'package:flutter/material.dart';
import 'package:izzi_ride_2/pages/main_page/components/tab_navigator.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/my_trips_tab/my_trips_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/profile_tab.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/search_tab.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late final PageController _pageController;

  int page = 0;

  List<Widget> pages=[
    SearchTab(),
    MyTripsTab(),
    SizedBox(),
    SizedBox(),
    ProfileTab()
  ];

  @override
  void initState() {
    _pageController=PageController(initialPage:page );
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
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  page=value;
                });
              },
              itemCount: pages.length,
              controller: _pageController,

              itemBuilder:  (context, index) {
                return pages[index];
              },
            )
          ),
          TabNavigator(
            page: page,pageController: _pageController
          )
        ],
      ),
    );
  }
}