import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/car_item.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class CarItemWidgetUI extends StatelessWidget {
  final CarItem carItem;
  final bool isSelected;
  const CarItemWidgetUI({super.key,required this.carItem,required this.isSelected});
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
        child: Stack(
          children: [
            Column(
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
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          Text(
                            carItem.brand+" "+carItem.model,
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 18,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      )
                      
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: BrandColor.grey244
                  ),
                  height: 154,
                  width: double.infinity,
                  child: Builder(
                    builder: (context) {
                      log(carItem.imageUrl.toString());
                      if(carItem.imageUrl==null || carItem.imageUrl!.isEmpty){
                        return defaultPhoto();
                      }
                      String? accessToken = GetIt.I.get<TokenInterface>().accessToken;
                      return Image.network(
                        AppConfig.photoUrl+carItem.imageUrl![0],
                        headers: {  
                          "Authorization":"Bearer "+(accessToken??""),
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return defaultPhoto();
                        },
                      );
                    }
                  )
                )
              ],
            ),
            if(isSelected) Positioned(
              bottom: 16,
              right: 16,
              child: R.SVG.SelectedCarIcon
            )
          ],
        ),
      ),
    );
  }

  Widget defaultPhoto(){
    return Container(
      decoration: BoxDecoration(
        color: BrandColor.grey244
      ),
      alignment: Alignment.center,
      child: R.Image.IllustrtationCar,
    );
  }

}