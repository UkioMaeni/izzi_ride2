import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/bloc/search_ride_bloc/search_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/select_car_scene/select_car_scene.dart';

class SearchTimeScene extends StatefulWidget {
  const SearchTimeScene({super.key});

  @override
  State<SearchTimeScene> createState() => _SearchTimeSceneState();
}

class _SearchTimeSceneState extends State<SearchTimeScene> {


  double elementHeiht = 76;
  late ScrollController _scrollController;
  late ScrollController _scrollPostfixController;
  int currentIndex=0;

  List<String> listTiming=[];

  
  double currentSpeed=0;
  double lastPosition=0;

  bool isPhysical=false;

  bool isSofting=false;
  double targets=0;

  double get width => MediaQuery.of(context).size.width;

  scrollListener(bool requiredScroll){
    setState(() {
      
    });
      double currentPosition = _scrollController.position.pixels;
      //print(currentPosition);
      currentSpeed=(currentPosition-lastPosition).abs();
      if(currentSpeed<0.4 && !isPhysical && !isSofting ||requiredScroll){
        isSofting=true;
        //print("/////////////////////");
       // print(currentPosition);
        int offsetCount = (currentPosition/elementHeiht).round().toInt();
        //print(offsetCount);
        double target = offsetCount*elementHeiht;
        targets=target;
       // print(target);
       // print("/////////////////////");
        _scrollController.animateTo(target, duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
      //print(currentSpeed);
      lastPosition=_scrollController.position.pixels;

      //print(_scrollController.position.pixels);
  }

  final PageController _pageController = PageController(initialPage: 0,viewportFraction: 0.33);

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: elementHeiht*300);
    _scrollPostfixController=ScrollController();
    _scrollController.addListener(()=>scrollListener(false));
    _scrollPostfixController.addListener(() => setState(() {}));
    super.initState();
    for(int i=0;i<24;i++){
      
      
      int initHour=i;
      bool isPM = false;
      if(i==0){
        initHour = 12;
      }
      if(i>12){
        initHour=i-12;
        isPM=true;
      }
      String hour = initHour<10?"0$initHour":"$initHour";
      for(int j=0;j<60;j=j+15){
        String minute = j<10?"0$j":"$j";
        String postfix=isPM?"PM":"AM";
        listTiming.add(hour+":"+minute);
      }
    }
  }

  double interpolate(double x) {
    return (10/3)*x*1.3;
  }
  bool isAm=true;

  DateTime variableTime=DateTime(0);

  @override
  Widget build(BuildContext context) {
    final searchRideBloc= context.read<SearchRideBloc>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              print("pop");
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 36),
              height: 50,
              alignment: Alignment.centerLeft,
              child: R.SVG.NavigationBackIcon,
            ),
          ),
          SizedBox(height: 56,),
          Text(
            "Select the date of travel",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: BrandFontFamily.platform,
              fontSize: 32,
              color: BrandColor.black,
              fontWeight: FontWeight.w700
            ),
          ),
          Expanded(
            child: CupertinoTheme(
                      
                        data:CupertinoThemeData(

                          applyThemeToAll: false,
                          textTheme:CupertinoTextThemeData(
                            
                            dateTimePickerTextStyle: TextStyle(
                            color: Theme.of(context).brightness==Brightness.dark?Colors.black:Colors.black,
                            wordSpacing: 40,
                            fontSize: 26
                          )
                          ) 
                        ), 
                        
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime: variableTime,
                            minuteInterval: 15,
                            
                            onDateTimeChanged: (DateTime newDateTime) {
                              variableTime = newDateTime;
                               //widget.update(newDateTime);
                               
                            },
                            
                          ),
                      ),
            // child: Container(
            //   color: Colors.white,
            //   alignment: Alignment.center,
            //   child: Padding(
            //     padding: const EdgeInsets.all(0),
                
            //     child: Listener(
            //       onPointerDown: (event) {
            //         isPhysical=true;
            //       },
            //       onPointerUp: (event) {
            //         isPhysical=false;
            //       },
                  
            //       child: SizedBox(
            //         height: elementHeiht*5,
            //         child: Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             Container(
            //                   height: elementHeiht,
            //                   width: width/1.7,
            //                   decoration: BoxDecoration(
            //                     color: BrandColor.grey244,
            //                     // border: Border.all(
            //                     //   color: BrandColor.blue
            //                     // ),
            //                     borderRadius: BorderRadius.circular(10)
            //                   ),
            //                 ),
            //                 Positioned(
            //                   left: 0,
            //                   top: 0,
            //                   bottom: 0,
            //                   child: Container(
            //                     //color: Color.fromARGB(169, 200, 198, 192),
            //                     //color: Colors.amber,
            //                     height: elementHeiht*5,
            //                     width: (width/1.7)/3*2,
            //                     child: NotificationListener<ScrollNotification>(
            //                       onNotification: (notification) {
            //                         if(notification is ScrollEndNotification){
            //                           //print("end");
            //                           if(!isSofting){
            //                            // print("dssssssssssssssssssssssssss");
            //                             scrollListener(false);
            //                             Future.delayed(Duration(milliseconds: 50)).then((_){
            //                               _scrollController.animateTo(targets, duration: Duration(milliseconds: 300), curve: Curves.linear);
            //                             });
                                        
            //                           }
            //                           isSofting=false;
            //                         }
            //                         return true;
            //                       },
            //                       child: CustomScrollView(
            //                         scrollBehavior: null,
            //                         physics: ClampingScrollPhysics(),
            //                         controller: _scrollController,
            //                         slivers: [
            //                           SliverList(
                                        
            //                             delegate: SliverChildBuilderDelegate(
                                          
            //                               (context, index) {
            //                                // print(index);
            //                                 currentIndex=index;
            //                                 double opacity=  (((_scrollController.offset)-(index-2)*elementHeiht).abs()/elementHeiht/10);
                                            
            //                                 return Container(
            //                                   alignment: Alignment.centerLeft,
            //                                   padding: EdgeInsets.only(left: 30),
            //                                   height: elementHeiht,
            //                                   //color: Colors.amber.withAlpha(index*100),
            //                                   child:Text(
            //                                         listTiming[index%listTiming.length],
                                                    
            //                                         style: TextStyle(
                                                      
            //                                           fontFamily: BrandFontFamily.platform,
            //                                           fontWeight: FontWeight.w700,
            //                                           fontSize: 32,
            //                                           color: BrandColor.black.withOpacity(1-interpolate(opacity).clamp(0, 1))
            //                                         ),
            //                                       ),
            //                                 );
            //                               },
                                                  
                                                    
            //                             )
            //                           )
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 ),
            //                 Positioned(
            //                   right: 0,
            //                   child: Container(
            //                     width: (width/1.7)/3,
                                
            //                     height: elementHeiht*3,
            //                     child: CustomScrollView(
            //                         scrollBehavior: null,
            //                         physics: ClampingScrollPhysics(),
            //                         controller: _scrollPostfixController,
            //                         slivers: [
            //                           SliverList(
            //                             delegate: SliverChildBuilderDelegate(
            //                               childCount: 4,
            //                               (context, index) {
            //                                 double opacity=  (((_scrollPostfixController.offset)-(index-1)*elementHeiht).abs()/elementHeiht/10);
            //                                 print(opacity);
            //                                 if(index==0|| index==3){
            //                                   return SizedBox(height: elementHeiht,);
            //                                 }
            //                                 return Container(
            //                                   alignment: Alignment.centerRight,
            //                                   padding: EdgeInsets.only(right: 30),
            //                                   height: elementHeiht,
            //                                   //color: Colors.amber.withAlpha(index*100),
            //                                   child:Text(
            //                                         index==1?"AM":"PM",
            //                                         style: TextStyle(
                                                      
            //                                           fontFamily: BrandFontFamily.platform,
            //                                           fontWeight: FontWeight.w700,
            //                                           fontSize: 32,
            //                                           color: BrandColor.black.withOpacity(1-opacity*4)
            //                                         ),
            //                                       ),
            //                                 );
            //                               },
                                                  
                                                    
            //                             )
            //                           )
            //                         ],
            //                       ),
            //                   )
            //                 )
            //                 // Positioned(
            //                 //   right: 0,
            //                 //   child: Container(
            //                 //     width: (width/1.5)/3,
            //                 //     //color: Colors.amber,
            //                 //     height: elementHeiht*3,
            //                 //     child: PageView(
            //                 //       controller: _pageController,
            //                 //       scrollDirection: Axis.vertical,
                                  
            //                 //       children: [
                                    
            //                 //         Container(
            //                 //           height: elementHeiht,
            //                 //           color: Colors.amber,
            //                 //           alignment: Alignment.center,
            //                 //           child: Text(
            //                 //             "AM",
            //                 //             style: TextStyle(         
            //                 //               fontFamily: BrandFontFamily.platform,
            //                 //               fontWeight: FontWeight.w700,
            //                 //               fontSize: 32,
            //                 //               color: BrandColor.black
            //                 //             ),
            //                 //           ),
            //                 //         ),
            //                 //         Container(
            //                 //           height: elementHeiht,
            //                 //           alignment: Alignment.center,
            //                 //           child: Text(
            //                 //             "PM",
            //                 //             style: TextStyle(         
            //                 //               fontFamily: BrandFontFamily.platform,
            //                 //               fontWeight: FontWeight.w700,
            //                 //               fontSize: 32,
            //                 //               color: BrandColor.black
            //                 //             ),
            //                 //           ),
            //                 //         ),
            //                 //       ],
            //                 //     )
            //                 //   )
            //                 // )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: UIButton(
              label: "Next",
              onTap: () {
                TimeOfDay time=TimeOfDay(hour: variableTime.hour, minute: variableTime.minute);
                searchRideBloc.add(SearchRideEditTime(time: time));
                context.goNamed(RoutesName.main);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCarScene(),));
              },
            ),
          ),
          SizedBox(height: 44,)
        ],
      ),
    );
  }
}