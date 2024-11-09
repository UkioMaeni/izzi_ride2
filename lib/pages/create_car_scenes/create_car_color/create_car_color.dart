import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';
import 'package:izzi_ride_2/core/models/color_library.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class CreateCarColor extends StatefulWidget {
  const CreateCarColor({super.key});

  @override
  State<CreateCarColor> createState() => _CreateCarColorState();
}

class _CreateCarColorState extends State<CreateCarColor> {



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
          NavBar(),
          SizedBox(height: 54,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Align(),
                Text(
                  "What color is your vehicle?",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 32,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 24,),
                for(final item in ColorCar.stringToColor.entries )
                colorItem(item)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget colorItem(MapEntry<String, Color> colorItem){
    return GestureDetector(
      onTap: () {
        context.read<CreateCarBloc>().add(CreateCarSelectColorCar(colorCar: ColorCar(stringColor: colorItem.key)));
        context.goNamed(RoutesName.createCarNumber);
      },
      child: Container(
        height: 40,
        color: Colors.white,
        padding: EdgeInsets.only(left: 12,right: 11),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: colorItem.value,
                    borderRadius: BorderRadius.circular(7)
                  ),
                ),
                SizedBox(width: 8,),
                Text(
                  colorItem.key,
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 18,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            R.SVG.ChevronRightBlack
          ],
        ),
      ),
    );
  }

}
//ColorCar