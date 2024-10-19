import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/pages/main_page/components/tab_element.dart';

class TabNavigator extends StatefulWidget {
  final int page;
  final TabController tabController;
  const TabNavigator({super.key,required this.page,required this.tabController});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  late int localPage;
  @override
  void initState() {
    localPage=widget.page;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      child: Row(
        children: [
          TabElement(
            onChange: () {
              localPage=0;
              //widget.tabController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.slowMiddle);
              widget.tabController.animateTo(0);
              setState(() {});
            },
            iconPath: "assets/svg/tab/search_tab.svg",
            label: "Search",
            currentPage: localPage,
            page: 0,
          ),
          TabElement(
            onChange: () {
              localPage=1;
              
              //widget.tabController.animateToPage(1, duration: Duration(milliseconds: 200), curve: Curves.linear);
              widget.tabController.animateTo(1);
              setState(() {});
            },
            iconPath: "assets/svg/tab/my_trips_tab.svg",
            label: "My trips",
            currentPage: localPage,
            page: 1,
          ),
          TabElement(
            onChange: () {
              localPage=2;
             // widget.tabController.animateToPage(2, duration: Duration(milliseconds: 200), curve: Curves.linear);
             widget.tabController.animateTo(2);
             setState(() {});
            },
            iconPath: "assets/svg/tab/profile_tab.svg",
            label: "Create",
            currentPage:localPage,
            page: 2,
          ),
          TabElement(
            onChange: () {
              localPage=3;
             // widget.tabController.animateToPage(3, duration: Duration(milliseconds: 200), curve: Curves.linear);
             widget.tabController.animateTo(3);
             setState(() {});
            },
            iconPath: "assets/svg/tab/profile_tab.svg",
            label: "Profile",
            currentPage: localPage,
            page: 3,
          ),
          TabElement(
            onChange: () {
              localPage=4;
              //widget.tabController.animateToPage(4, duration: Duration(milliseconds: 200), curve: Curves.easeInOutCirc);
              widget.tabController.animateTo(4);
              setState(() {});
            },
            iconPath: "assets/svg/tab/profile_tab.svg",
            label: "Profile",
            currentPage: localPage,
            page: 4,
          ),
        ],
      ),
    );
  }
}