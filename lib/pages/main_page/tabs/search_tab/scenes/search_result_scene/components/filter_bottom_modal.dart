import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/models/search_filter.dart';

class FilterBottomModal extends StatefulWidget {
  const FilterBottomModal({super.key});

  @override
  State<FilterBottomModal> createState() => _FilterBottomModalState();
}

class _FilterBottomModalState extends State<FilterBottomModal> {

  List<SearchFilter> filters=[
    SearchFilter(category: ECategory.Sort, value: "The earliest trips"),
    SearchFilter(category: ECategory.Sort, value: "The cheapest trips"),
    SearchFilter(category: ECategory.Sort, value: "Close to the exit point"),
    SearchFilter(category: ECategory.Sort, value: "Close to the point of arrival"),
  ];

  Map<ECategory, SearchFilter> lastVersionCategoryes ={};
  @override
  void initState() {
    lastVersionCategoryes=context.read<SearchRideBloc>().state.filters; 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(),
          SizedBox(height: 28,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter",
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 32,
                  color: BrandColor.black,
                  fontWeight: FontWeight.w700
                ),
              ),
              Container(
                height: 58,
                width: 58,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: BrandColor.black
                  ),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Icon(Icons.close,size: 30,),
              )
            ],
          ),
          SizedBox(height: 56,),
          Text(
            ECategory.Sort.name,
            style: TextStyle(
              fontFamily: BrandFontFamily.platform,
              fontSize: 26,
              color: BrandColor.black,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 32,),
          Builder(
            builder: (context) {
              final currentFilterInCategory= context.watch<SearchRideBloc>().state.filters[ECategory.Sort];
              return Column(children: filters.map((e) => categoryItem(e,currentFilterInCategory),).toList(),);
            }
          ),
          SizedBox(height: 32,),
          UIButton(
            label: "Apply",
            onTap: () {
              final searchRideBloc = context.read<SearchRideBloc>();
              searchRideBloc.add(SearchRideUpdateFiltersEditing(isEditing: false));
            },
          ),
          SizedBox(height: 9,)
        ],
      ),
    );
  }

  Widget categoryItem(SearchFilter filter,SearchFilter? currentFilterInCategory){
    print(filter.value);
    inspect(currentFilterInCategory);
    return GestureDetector(
      onTap: () {
        final searchRideBloc= context.read<SearchRideBloc>();
        searchRideBloc.add(SearchRideUpdateFilters(filters: filter));
      },
      child: Container(
        height: 44,
        color: Colors.white,
        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              filter.value,
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 18,
                color: BrandColor.black,
                fontWeight: FontWeight.w500
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: currentFilterInCategory!=null&&(currentFilterInCategory.value!=filter.value)||currentFilterInCategory==null?Colors.transparent: BrandColor.blue,
                border: Border.all(
                  color: BrandColor.blue,
                  width: 2
                )
              ),
            )
          ],
        ),
      ),
    );
  }

}