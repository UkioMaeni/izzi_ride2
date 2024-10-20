import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/select_car_scene/select_car_scene.dart';

class TimeScene extends StatefulWidget {
  const TimeScene({super.key});

  @override
  State<TimeScene> createState() => _TimeSceneState();
}

class _TimeSceneState extends State<TimeScene> {


  double elementHeiht = 76;
  late ScrollController _scrollController;
  int currentIndex=0;

  List<String> listTiming=[];

  
  double currentSpeed=0;
  double lastPosition=0;

  bool isPhysical=false;

  bool isSofting=false;
  double targets=0;
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

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: elementHeiht*300);
    _scrollController.addListener(()=>scrollListener(false));
    for(int i=0;i<24;i++){
      String hour = i<10?"0$i":"$i";
      for(int j=0;j<60;j=j+15){
        String minute = j<10?"0$j":"$j";
        listTiming.add(hour+":"+minute);
      }
      
    }
    super.initState();
  }

  double interpolate(double x) {
  const double minX = 0.3;
  const double maxX = 0.6;
  const double minY = 0;
  const double maxY = 1;

  return (10/3)*x*1.3;
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
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
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
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                
                child: Listener(
                  onPointerDown: (event) {
                    isPhysical=true;
                  },
                  onPointerUp: (event) {
                    isPhysical=false;
                  },
                  
                  child: SizedBox(
                    height: elementHeiht*5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                              height: 74,
                              width: 213,
                              decoration: BoxDecoration(
                                color: BrandColor.grey244,
                                border: Border.all(
                                  color: BrandColor.blue
                                ),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            ),
                            
                        Container(
                              height: 74*5,
                              
                              child: NotificationListener<ScrollNotification>(
                                onNotification: (notification) {
                                  if(notification is ScrollEndNotification){
                                    //print("end");
                                    if(!isSofting){
                                     // print("dssssssssssssssssssssssssss");
                                      scrollListener(false);
                                      Future.delayed(Duration(milliseconds: 50)).then((_){
                                        _scrollController.animateTo(targets, duration: Duration(milliseconds: 300), curve: Curves.linear);
                                      });
                                      
                                    }
                                    isSofting=false;
                                  }
                                  return true;
                                },
                                child: CustomScrollView(
                                  physics: ClampingScrollPhysics(),
                                  controller: _scrollController,
                                  slivers: [
                                    SliverList(
                                      
                                      delegate: SliverChildBuilderDelegate(
                                        
                                        (context, index) {
                                         // print(index);
                                          currentIndex=index;
                                          double opacity=  (((_scrollController.offset)-(index-2)*elementHeiht).abs()/elementHeiht/10);
                                          print(interpolate(opacity));
                                          return Container(
                                            alignment: Alignment.center,
                                            height: elementHeiht,
                                            child:Text(
                                                  listTiming[index%listTiming.length],
                                                  
                                                  style: TextStyle(
                                                    
                                                    fontFamily: BrandFontFamily.platform,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 32,
                                                    color: BrandColor.black.withOpacity(1-interpolate(opacity).clamp(0, 1))
                                                  ),
                                                ),
                                          );
                                        },
                    
                                                  
                                      )
                                    )
                                  ],
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: UIButton(
              label: "Next",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SelectCarScene(),));
              },
            ),
          ),
          SizedBox(height: 44,)
        ],
      ),
    );
  }
}