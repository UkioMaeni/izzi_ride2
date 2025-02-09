import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class Similare extends StatefulWidget {
  const Similare({super.key});

  @override
  State<Similare> createState() => _SimilareState();
}

class _SimilareState extends State<Similare> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: BrandColor.black,
            blurRadius: 2,
            offset: Offset(0, 2),
            spreadRadius: 2
          )
        ],
        // border: Border(
        //   top: BorderSide(
        //     color: BrandColor.black
        //   )
        // )
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            Text(
              "The dates on which the trips are made.",
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 18,
                color: BrandColor.black,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 13,),
            Row(
              children: [
                similareElement("07 may")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget similareElement(String text){
    return Container(
      decoration: BoxDecoration(
        color: BrandColor.lightGreen,
        borderRadius: BorderRadius.circular(17)
      ),
      alignment: Alignment.center,
      height: 34,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Text(
                text,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 15,
                  color: BrandColor.green,
                  fontWeight: FontWeight.w600
                ),
              ),
    );
  }

}