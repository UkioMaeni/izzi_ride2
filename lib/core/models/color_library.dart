import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class ColorCar{
  String stringColor;
  ColorCar({
    required this.stringColor
  });
  Color get color => ColorCar.stringToColor[stringColor]??Colors.black;

  static Map<String,Color> stringToColor={
          "Black": Colors.black,
          "Grey": BrandColor.grey227,
        };
  static Map<int,String> colorintToString={
        Colors.black.value:"Black",
          BrandColor.grey227.value:"Grey",
        };
}
