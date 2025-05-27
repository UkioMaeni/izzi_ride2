import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/UI/animated_button.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/models/enum_ride_type.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
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
    return 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 21,),
                  Image.asset("assets/image/search/car.png"),
                  SizedBox(height: 42,),
                  Container(
                    width: double.infinity,
                    height: 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: BrandColor.grey244,
                      borderRadius: BorderRadius.circular(56)
                    ),
                    child: Builder(
                      builder: (context) {
                        final searchBloc=context.read<SearchRideBloc>();
                        final type= context.watch<SearchRideBloc>().state.rideType;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                searchBloc.add(SearchRideEditSearchType(type: EnumRideType.client));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:type==EnumRideType.client? BrandColor.blue:BrandColor.grey244,
                                  borderRadius: BorderRadius.circular(55)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "Finde ride",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 18,
                                    color:type==EnumRideType.client? Colors.white:BrandColor.grey167,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                searchBloc.add(SearchRideEditSearchType(type: EnumRideType.driver));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:type==EnumRideType.driver? BrandColor.blue:BrandColor.grey244,
                                  borderRadius: BorderRadius.circular(55)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "Offer ride",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 18,
                                    color:type==EnumRideType.driver? Colors.white:BrandColor.grey167,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                searchBloc.add(SearchRideEditSearchType(type: EnumRideType.delivery));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color:type==EnumRideType.delivery? BrandColor.blue:BrandColor.grey244,
                                  borderRadius: BorderRadius.circular(55)
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  "Delivery",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 18,
                                    color:type==EnumRideType.delivery? Colors.white:BrandColor.grey167,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                  SizedBox(height: 32,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 12,
                          color:BrandColor.black69,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 8,),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RoutesName.searchFromInput);
                        },
                        child: Container(
                          height: 66,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: BrandColor.grey244,
                            border: Border.all(
                              color: BrandColor.blue
                            )
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 12,),
                              R.SVG.SearchLocation,
                              SizedBox(width: 10,),
                              Builder(
                                builder: (context) {
                                  final location= context.watch<SearchRideBloc>().state.fromLocation;
                                  return Expanded(
                                    child: Text(
                                      location.fullAddress.isEmpty?"New York":location.fullAddress,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: BrandFontFamily.platform,
                                        fontSize: 20,
                                        color:location.fullAddress.isEmpty?BrandColor.grey167:BrandColor.black69,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24,),
                      Text(
                        "To",
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 12,
                          color:BrandColor.black69,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 8,),
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(RoutesName.searchToInput);
                        },
                        child: Container(
                          height: 66,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: BrandColor.grey244,
                            border: Border.all(
                              color: BrandColor.blue
                            )
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 12,),
                              R.SVG.SearchLocation,
                              SizedBox(width: 10,),
                              Builder(
                                builder: (context) {
                                  final location= context.watch<SearchRideBloc>().state.toLocation;
                                  return Expanded(
                                    child: Text(
                                      location.fullAddress.isEmpty?"Arizona":location.fullAddress,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: BrandFontFamily.platform,
                                        fontSize: 20,
                                        color:location.fullAddress.isEmpty?BrandColor.grey167:BrandColor.black69,
                                        fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  );
                                }
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24,),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 12,
                                    color:BrandColor.black69,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(height: 8,),
                                GestureDetector(
                                  onTap: () {
                                    context.pushNamed(RoutesName.searchCalendare);
                                  },
                                  child: Container(
                                    height: 66,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: BrandColor.grey244,
                                      border: Border.all(
                                        color: BrandColor.blue
                                      )
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 12,),
                                        R.SVG.SearchLocation,
                                        SizedBox(width: 10,),
                                        Builder(
                                          builder: (context) {
                                            final state= context.watch<SearchRideBloc>().state;
                                            DateTime fullDate=DateTime(
                                              state.date.year,
                                              state.date.month,
                                              state.date.day,
                                              state.time.hour,
                                              state.time.minute,
                                            );
                                            log(fullDate.toString());
                                            String formattedDate=DateFormat("ddMMM, hh:mm a","en_US").format(fullDate);
                                            return Text(
                                              formattedDate,
                                              style: TextStyle(
                                                fontFamily: BrandFontFamily.platform,
                                                fontSize: 18,
                                                color:BrandColor.black69,
                                                fontWeight: FontWeight.w400
                                              ),
                                            );
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 12,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Seats",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    fontSize: 12,
                                    color:BrandColor.black69,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                SizedBox(height: 8,),
                                GestureDetector(
                                  onTap: () {
                                    context.pushNamed(RoutesName.searchCounter);
                                  },
                                  child: Container(
                                    height: 66,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: BrandColor.grey244,
                                      border: Border.all(
                                        color: BrandColor.blue
                                      )
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: 12,),
                                        R.SVG.SearchLocation,
                                        SizedBox(width: 10,),
                                        Builder(
                                          builder: (context) {
                                            final personCount= context.watch<SearchRideBloc>().state.personCount;
                                            return Text(
                                              personCount.toString(),
                                              style: TextStyle(
                                                fontFamily: BrandFontFamily.platform,
                                                fontSize: 20,
                                                color:BrandColor.black69,
                                                fontWeight: FontWeight.w400
                                              ),
                                            );
                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                      
                    ],
                  ),
                  Expanded(child: SizedBox.fromSize()),
                  Builder(
                    builder: (context) {
                      final state= context.watch<SearchRideBloc>().state;
                      bool  isActive=state.fromLocation.fullAddress.isNotEmpty&&state.toLocation.fullAddress.isNotEmpty;
                      return UIButton(
                        label: "Search",
                        backgroundColor:isActive? BrandColor.blue:BrandColor.notActiveBlue,
                        onTap: () {
                          //if(!isActive) return;
                          context.pushNamed(RoutesName.searchResult);
                        },
                      );
                    }
                  ),
                  SizedBox(height: 20,) 
                ],
              
            ),
    );
  }
}