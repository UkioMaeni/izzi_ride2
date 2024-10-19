import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/UI/ui_text_field.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/tools/debounce.dart';

class FromSearchScene extends StatefulWidget {
  const FromSearchScene({super.key});

  @override
  State<FromSearchScene> createState() => _FromSearchSceneState();
}

class _FromSearchSceneState extends State<FromSearchScene> {

  final _overlayKey = GlobalKey();
  final Debounce debounce = Debounce(duration: Duration(milliseconds: 300));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8,),
              navbar(),
              SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    UITextField(
                      hintText: "From",
                      onChanged: (value) {
                        debounce.debounce(()=>(){});
                      },
                    )
                  ],
                ),
              )
              
          
            ],
          ),
          Positioned(
            top: 172,
            left: 24,
            right: 0,
            child: Container(
              height: 66*4,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return searchItem();
                },
              ),
            )
          )
        ],
      ),
    );
  }

  Widget searchItem(){
    return GestureDetector(
      onTap: () {
        
      },
      child: Container(
        height: 66,
        padding: EdgeInsets.only(top: 11.5,bottom: 7.5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: BrandColor.grey167
            )
          )
        ),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Text(
                "Nebraska City",
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 18,
                  color: BrandColor.black,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                "NE, USA",
                style: TextStyle(
                  fontFamily: "SF",
                  fontSize: 12,
                  color: BrandColor.grey167,
                  fontWeight: FontWeight.w400
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget navbar(){
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 13.5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 36,),
            SvgPicture.asset("assets/svg/navigation/navigation_back.svg"),
            SizedBox(width: 10,),
            Text(
              "From",
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: BrandColor.black
              ),
            ),
          ],
        ),
      ),
    );
  }
}