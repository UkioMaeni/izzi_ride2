import 'package:flutter/material.dart';
import 'package:izzi_ride_2/UI/animated_button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/components/header_search.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/components/new_area.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 54,),
          HeaderSearch(),
          SizedBox(height: 44,),
          NewArea(),
          
        ],
      ),
    );
  }
}