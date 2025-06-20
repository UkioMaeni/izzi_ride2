import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/UI/trip_card/trip_card.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_result_scene/components/filter_bottom_modal.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_result_scene/components/filters.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_result_scene/components/result.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenes/search_result_scene/components/similare.dart';

class SearchResultScene extends StatefulWidget {
  const SearchResultScene({super.key});

  @override
  State<SearchResultScene> createState() => _SearchResultSceneState();
}

class _SearchResultSceneState extends State<SearchResultScene> {


  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              NavBar(
                title: "Search results",
              ),
              Positioned(
                right: 24,
                child: GestureDetector(
                  onTap: () {
                    final searchRideBloc = context.read<SearchRideBloc>();
                    searchRideBloc.add(SearchRideUpdateFiltersEditing(isEditing: true));
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return FilterBottomModal();
                      },
                    );
                  },
                  child: SvgPicture.asset("assets/svg/search/filter.svg")
                )
              )
            ],
          ),
          Filtres(),
          Expanded(
            child: Result()
          ),
          Similare(),
        ],
      ),
    );
  }



}