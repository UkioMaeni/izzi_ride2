import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class UITabHeader extends StatelessWidget {
  final double leftPadding;
  final String label;
  const UITabHeader({super.key,required this.label,this.leftPadding=12});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: leftPadding),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: BrandFontFamily.platform,
          color: BrandColor.black69,
          fontSize: 32,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}