import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';

class CarItemWidgetUI extends StatelessWidget {
  final CarItem carItem;
  const CarItemWidgetUI({super.key,required this.carItem});
  static Widget AddCar(){
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: BrandColor.blue,
          width: 2
        )
      ),
      child:  SizedBox(
        height: 217,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "+\nAdd car",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 20,
                color: BrandColor.blue,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 217,
        child: Column(
          children: [
            Container(
              height: 63,
              decoration: BoxDecoration(
                color: BrandColor.grey244
              ),
              padding: EdgeInsets.only(left: 12,right: 19.3),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "car model",
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 12,
                          color: BrandColor.black,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                      Text(
                        "BMW 3 SERIES",
                        style: TextStyle(
                          fontFamily: BrandFontFamily.platform,
                          fontSize: 18,
                          color: BrandColor.black,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  )
                  
                ],
              ),
            ),
            SizedBox(
              height: 154,
              width: double.infinity,
              child: Image.network(
                "https://cdn.ingos.ru/images/blog/samye-dorogie-avtomobili_shut.jpg",
                fit: BoxFit.cover,
              )
            )
          ],
        ),
      ),
    );
  }
}