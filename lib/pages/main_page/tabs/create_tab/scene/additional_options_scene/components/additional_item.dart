import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';



class AdditionalItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final Function(bool selected) onChangeSelected;
  const AdditionalItem({super.key,required this.title,required this.isSelected,required this.onChangeSelected});

  @override
  State<AdditionalItem> createState() => _AdditionalItemState();
}

class _AdditionalItemState extends State<AdditionalItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=> widget.onChangeSelected(!widget.isSelected),
      child: Container(
        height: 76,
        decoration: BoxDecoration(
          color: BrandColor.grey244,
          borderRadius: BorderRadius.circular(13)
        ),
        child: Row(
          children: [
            SizedBox(width: 18,),
            Builder(
              builder: (context) {
               
                return Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 20,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w400
                  ),
                );
              }
            ),
            Expanded(child: SizedBox()),
            widget.isSelected?R.SVG.SelectedAdditionalGreen: R.SVG.SelectedAdditionalGrey,
            SizedBox(width: 18,)
          ],
        ),
      ),
    );
  }
}