import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class CreateCarSeats extends StatefulWidget {
  const CreateCarSeats({super.key});

  @override
  State<CreateCarSeats> createState() => _CreateCarSeatsState();
}

class _CreateCarSeatsState extends State<CreateCarSeats> {


  CreateCarBloc  get createCarBloc => context.read<CreateCarBloc>();

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
          SizedBox(height: 64,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(),
                  Text(
                    "Select the number of seats.",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 32,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                    
                  ),
                  SizedBox(height: 163,),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap:priceMinus,
                          child: Container(
                            padding: EdgeInsets.only(right: 32),
                            alignment: Alignment.centerRight,
                            child: R.SVG.PriceMinus
                          ),
                        )
                      ),
                      Container(
                        width: 180,
                        height: 80,
                        decoration: BoxDecoration(
                          color: BrandColor.grey244,
                          border: Border.all(
                            color: BrandColor.blue
                          ),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Stack(
                          children: [
                            Align(
                              child: Builder(
                                builder: (context) {
                                  final seats = context.watch<CreateCarBloc>().state.seats;
                                  return Text(
                                    seats.toString(),
                                    style: TextStyle(
                                      color: BrandColor.black,
                                      fontFamily: BrandFontFamily.platform,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700
                                    ),
                                  );
                                }
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: pricePlus,
                          child: Container(
                            padding: EdgeInsets.only(left: 32),
                            alignment: Alignment.centerLeft,
                            child: R.SVG.PricePlus
                          ),
                        )
                      )
                    ],
                  ),
                  Expanded(child: SizedBox.shrink()),
                  UIButton(
                    label: "Next",
                    onTap: () {
                      context.goNamed(RoutesName.createCarColor);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => AdditionalOptionsScene(),));
                    },
                  ),
                  SizedBox(height: 44,)
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }

  void priceMinus() {
    if(createCarBloc.state.seats<=1) return;
    createCarBloc.add(CreateCarSelectSeats(seats: createCarBloc.state.seats-1));
  }

  void pricePlus() {
    if(createCarBloc.state.seats>=4) return;
    createCarBloc.add(CreateCarSelectSeats(seats: createCarBloc.state.seats+1));
  }
}