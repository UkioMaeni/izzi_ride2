import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class PaymentItem extends StatelessWidget {
  final int paymentId;
  final String title;
  final bool isSelected;
  final Function(bool selected) onChangeSelected;
  const PaymentItem({super.key,required this.paymentId, required this.title,required this.isSelected,required this.onChangeSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=>onChangeSelected(isSelected),
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
                  title,
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 20,
                    color: BrandColor.black69,
                    fontWeight: FontWeight.w400
                  ),
                );
              }
            ),
            Expanded(child: SizedBox()),
            isSelected?R.SVG.SelectedAdditionalGreen: R.SVG.SelectedAdditionalGrey,
            SizedBox(width: 18,)
          ],
        ),
      ),
    );
  }
}