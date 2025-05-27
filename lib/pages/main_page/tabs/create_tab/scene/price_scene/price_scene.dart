import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/price_scene/components/price_engine.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/price_scene/components/price_information.dart';

class PriceScene extends StatefulWidget {
  const PriceScene({super.key});

  @override
  State<PriceScene> createState() => _PriceSceneState();
}

class _PriceSceneState extends State<PriceScene> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
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
          SizedBox(height: 44,),
          Text(
            "Set the price for the trip",
            style: TextStyle(
              fontFamily: BrandFontFamily.platform,
              fontSize: 32,
              color: BrandColor.black69,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(height: 153,),
          PriceEngine(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Expanded(child: SizedBox.shrink()),
                  PriceInformation(),
                  SizedBox(height: 64,),
                  UIButton(
                    label: "Next",
                    onTap: () {
                      context.goNamed(RoutesName.payment);
                    },
                  ),
                  SizedBox(height: 44,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



}