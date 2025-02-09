import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

TextStyle localTextStyle = const TextStyle(
  color: Color.fromRGBO(58,121,215,1),
  fontFamily: "Inter",
  fontSize: 16,
  fontWeight: FontWeight.w500
);


class PersonCounterScene extends StatefulWidget {
 const  PersonCounterScene();


  @override
  State<PersonCounterScene> createState() => _PersonCounterScene();
}
DateTime date=DateTime.now();


class _PersonCounterScene extends State<PersonCounterScene> {



@override
  void initState() {
    //count=widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
            NavBar(
              
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 12,left: 15,right: 15),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Padding(
                    //   padding: EdgeInsets.only(top: 20,bottom: 20),
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       "Number of reserved seats",
                    //       textAlign: TextAlign.center,
                    //       style: TextStyle(
                    //         fontFamily: "SF",
                    //         fontSize: 24,
                    //         fontWeight: FontWeight.w700,
                    //         color: Color.fromRGBO(51,51,51,1)
                    //       ),
                    //       ),
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Center(
                          child: Builder(
                            builder: (context) {
                              final searchRideBloc = context.watch<SearchRideBloc>();
                              final searchRideBlocState=searchRideBloc.state;
                              final count=searchRideBlocState.personCount;
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      if(count>1){
                                        searchRideBloc.add(SearchRideEditPersonCounter(count: count-1));
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      "assets/svg/search/personMinus.svg",
                                        // ignore: deprecated_member_use
                                        color:count>1?BrandColor.blue:const Color.fromRGBO(177,177,177,1),
                                    ),
                                  ),
                                  Text(
                                    searchRideBlocState.personCount.toString(),
                                    style: const TextStyle(
                                      fontFamily: "SF",
                                      fontSize: 56,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromRGBO(51,51,51,1)
                                    )
                                    ),
                                   InkWell(
                                    onTap: (){
                                      if(count<4){
                                        searchRideBloc.add(SearchRideEditPersonCounter(count: count+1));
                                      }
                                    },
                                     child: SvgPicture.asset(
                                      "assets/svg/search/personPlus.svg",
                                        // ignore: deprecated_member_use
                                        color:count<4?BrandColor.blue:const Color.fromRGBO(177,177,177,1),
                                                         ),
                                   )
                                ],
                              );
                            }
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}