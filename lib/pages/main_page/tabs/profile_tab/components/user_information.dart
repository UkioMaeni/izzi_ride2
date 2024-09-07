import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/pages/main_page/photo_scene/photo_scene.dart';

class UserInformation extends StatelessWidget {
  final String fullName;
  final bool isVerify;
  final double rate;
  final String? photoUri;
  const UserInformation({super.key,required this.fullName,required this.isVerify,required this.rate,required this.photoUri});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 102,
      child: Row(
        children: [
          Builder(
            builder: (context) {
              if(photoUri==null){
                return GestureDetector(
                  onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context) => PhotoScenePage(photoSceneType: PhotoSceneType.user,))),
                  child: SvgPicture.asset("assets/svg/profile/user_not_photo.svg")
                );
              }
              return SizedBox.shrink();
            },
          ),
          SizedBox(width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  color: BrandColor.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20
                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Text(
                    "Novice",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 12
                    ),
                  ),
                  SizedBox(width: 5,),
                  if(isVerify) SvgPicture.asset("assets/svg/profile/verify.svg",width: 12,height: 12,)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}