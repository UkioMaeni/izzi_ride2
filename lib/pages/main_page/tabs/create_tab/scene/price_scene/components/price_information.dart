import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';

class PriceInformation extends StatelessWidget {
  PriceInformation({super.key});

  final String lowPrice=
    "It might be worth raising the price to split the cost of the trip in a better way. Passengers will not keep you waiting!";
  final String normalPrice=
    "The best price for this trip!\nThe passengers will not keep you waiting.";
  final String highPrice=
    "Lower the price to attract more passengers.";

  final Color lowPriceColor=BrandColor.blue;
  final Color normalPriceColor=BrandColor.green;
  final Color highPriceColor=BrandColor.red;

  final int recomendedMinValue=20; 
  final int recomendedMaxValue=25;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) {
          final price= context.watch<CreateRideBloc>().state.price;
          print(price);
          String text=normalPrice;
          Color color = normalPriceColor;
          if(price<recomendedMinValue){
            text=lowPrice;
            color=lowPriceColor;
          }else if(price>recomendedMaxValue){
            text=highPrice;
            color=highPriceColor;
          }
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                  
                ),
                constraints: BoxConstraints(
                  minHeight: 41
                ),
                alignment: Alignment.center,
                child: Text(
                  "The cost of this trip can range from \$$recomendedMinValue-\$$recomendedMaxValue.",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 16,),
              Text(
                text,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 16,
                  color: BrandColor.grey167,
                  fontWeight: FontWeight.w400
                ),
              )
            ],
          );
        }
      ),
    );
  }
}