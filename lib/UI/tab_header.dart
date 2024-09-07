import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class UITabHeader extends StatelessWidget {
  final String label;
  const UITabHeader({super.key,required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 12),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: BrandFontFamily.platform,
          color: BrandColor.black,
          fontSize: 32,
          fontWeight: FontWeight.w700
        ),
      ),
    );
  }
}