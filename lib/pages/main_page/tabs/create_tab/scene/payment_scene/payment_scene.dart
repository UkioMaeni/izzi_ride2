import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/payment_scene/components/payment_item.dart';

class PaymentScene extends StatefulWidget {
  const PaymentScene({super.key});

  @override
  State<PaymentScene> createState() => _PaymentSceneState();
}

class _PaymentSceneState extends State<PaymentScene> {


  CreateRideBloc get createRideBloc => context.read<CreateRideBloc>();



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
                      color: BrandColor.black69,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 32,),
                  PaymentItem(
                    paymentId: 1,
                    title: "Cash",
                    isSelected: createRideBloc.state.paymaentMetodId==1,
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