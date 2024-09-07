import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class ListItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final String? status;
  final Function()? onTap;
  const ListItem({super.key,required this.icon,required this.label,this.status,this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap??(){},
      child: Container(
        height: 39,
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 8,),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 18,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            Builder(
              builder: (context) {
                if(status==null){
                  return SizedBox.shrink();
                }
                if(status=="no"){
                  return SvgPicture.asset("assets/svg/profile/add.svg");
                }
                if(status=="completed"){
                  return SvgPicture.asset("assets/svg/profile/completed.svg");
                }
                return SizedBox.shrink();
              },
            )
            
          ],
        ),
      ),
    );
  }
}