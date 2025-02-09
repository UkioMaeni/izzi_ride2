import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class NavBar extends StatelessWidget {
  final Function()? onBack;
  final String? title;
  const NavBar({super.key,this.onBack,this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          SizedBox(height: 8,),
          GestureDetector(
            onTap: () {
              if(onBack!=null){
                onBack!();
              }else{
                Navigator.pop(context);
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 36),
                  height: 50,
                  alignment: Alignment.centerLeft,
                  child: R.SVG.NavigationBackIcon,
                ),
                Text(
                  title??"",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 25,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}