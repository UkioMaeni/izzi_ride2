import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'dart:math' as math;
class NewArea extends StatefulWidget {
  const NewArea({super.key});

  @override
  State<NewArea> createState() => _NewAreaState();
}

class _NewAreaState extends State<NewArea> {

  double get width => MediaQuery.of(context).size.width;

  final PageController _pageController = PageController(initialPage: 0,viewportFraction: 0.9);
  final ScrollController _scrollController = ScrollController();
  int currentPage=0;
  double velocity = 0;
  bool scrolling=true;
  @override
  void initState() {
    _scrollController.addListener(() {
      //print(_scrollController.offset);
      double offset=_scrollController.offset;
      
    },);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: titleWidget(),
        ),
        SizedBox(height: 16,),
        SizedBox(
          height: 380,
          child: PageView.builder(
            dragStartBehavior: DragStartBehavior.start,
            controller: _pageController,
            itemCount: 3,
            onPageChanged: (value) {
              setState(() {
                currentPage=value;
              });
            },
            itemBuilder: (context, index) {
              return pageItem(index);
            },
          ),
          // child: PageView.custom(
          //   dragStartBehavior: DragStartBehavior.start,
          //   allowImplicitScrolling: false,
          //   childrenDelegate: SliverChildBuilderDelegate(

          //   (context, index){
          //     return pageItem(index);
          //   },
          //   childCount: 5
          //   ),
          // )
          // child: PageView(

          //   children: [
          //     pageItem(0),
          //     pageItem(0),
          //     pageItem(0),
          //   ],
          // ),
          // child: Listener(
          //   onPointerUp: (event) {
          //     if(velocity>=20){
          //       setState(() {
          //         scrolling=false;
          //       });
          //     }
          //   },
          //   child: NotificationListener<ScrollNotification>(
          //     onNotification: (notification) {
          //       if(notification is ScrollUpdateNotification){
          //         double? delta = notification.scrollDelta;
          //         velocity=delta!.abs();
          //         print(delta);
          //       }
          //       if(notification is ScrollEndNotification){
                  
          //         print("end");
          //       }
          //       return false;
          //     },
          //     child: CustomScrollView(
          //       scrollDirection: Axis.horizontal,
          //       controller: _scrollController,
          //       slivers: [
          //         SliverList(
          //           delegate: SliverChildBuilderDelegate(
          //             (context, index) {
          //               return pageItem(index);
          //             },
          //             childCount: 5
          //           )
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        )
      ],
    );
  }

  Widget pageItem(int index){
    return  Padding(
        padding: EdgeInsets.only(left: 0,right: 0),
        child: Align(
          alignment: Alignment.center,
          child:  Container(
              height: 380,
              alignment: Alignment.center,
              width:width-48,
              decoration: BoxDecoration(
                color: BrandColor.grey244,
                borderRadius: BorderRadius.circular(12)
              ),
            ),
          
        
      ),
    );
  }

  Widget titleWidget(){
    return Container(
      height: 43,
      width: 71,
      decoration: BoxDecoration(
        color: BrandColor.blue,
        borderRadius: BorderRadius.circular(29)
      ),
      alignment: Alignment.center,
      child: Text(
              "New",
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500
              ),
            ),
    );
  }
}