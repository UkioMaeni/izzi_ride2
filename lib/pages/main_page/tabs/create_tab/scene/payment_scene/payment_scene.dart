import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/payment_scene/components/payment_item.dart';

class PaymentScene extends StatefulWidget {
  const PaymentScene({super.key});

  @override
  State<PaymentScene> createState() => _PaymentSceneState();
}

class _PaymentSceneState extends State<PaymentScene> {
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
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    "Choose the payment method",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 32,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 32,),
                  PaymentItem(
                    title: "Cash",
                    isSelected: true,
                    onChangeSelected: (_){}
                  ),
                  Expanded(child: SizedBox.shrink()),
                  UIButton(
                    label: "Done",
                    onTap: () {
                      context.goNamed(RoutesName.createInstant);
                    },
                  ),
                  SizedBox(height: 44,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}