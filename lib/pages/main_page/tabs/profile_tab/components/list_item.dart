import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/enum_checked_status.dart';

// enum EListItemStatus{
//   completed,disabled,required
// }


class ListItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final EnumCheckedStatus status;
  final Function()? onTap;
  const ListItem({super.key,required this.icon,required this.label,this.status=EnumCheckedStatus.unconfirmed,this.onTap});

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
                    color: status==EnumCheckedStatus.pending?BrandColor.grey167: BrandColor.black69,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
            Builder(
              builder: (context) {

                switch(status){
                  case EnumCheckedStatus.confirmed: return SvgPicture.asset("assets/svg/profile/completed.svg");
                  case EnumCheckedStatus.unconfirmed: return SvgPicture.asset("assets/svg/profile/add.svg");
                  case EnumCheckedStatus.pending: return SvgPicture.asset("assets/svg/profile/pending.svg");
                  case EnumCheckedStatus.disabled: return SizedBox.shrink();
                }
                // if(status==null){
                //   return SizedBox.shrink();
                // }
                // if(status=="no"){
                //   return SvgPicture.asset("assets/svg/profile/add.svg");
                // }
                // if(status=="completed"){
                //   return SvgPicture.asset("assets/svg/profile/completed.svg");
                // }
                // return SizedBox.shrink();
              },
            )
            
          ],
        ),
      ),
    );
  }
}