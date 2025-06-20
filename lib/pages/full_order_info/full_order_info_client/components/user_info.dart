import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izzi_ride_2/UI/user_photo.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/ride_model.dart';

class UserInfo extends StatelessWidget {
  final String? photoUrl;
  final String name;
  final double rate;
  final bool isNovice;
  const UserInfo({super.key,required this.photoUrl,required this.name,required this.rate,required this.isNovice,});

  @override
  Widget build(BuildContext context) {
    return Row(
                children: [
                  
                  UIUserPhoto(url: photoUrl),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          
                          Text(
                            name,
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 15,
                              color: BrandColor.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(width: 5,),
                          if(isNovice) SvgPicture.asset("assets/svg/profile/verify.svg",width: 12,height: 12,),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "⭐ "+rate.toString(),
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 15,
                              color: BrandColor.black,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          
                        ],
                      ),
                      Row(
                        children: [
                          
                          
                          Text(
                            "Novice",
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              color: BrandColor.black69,
                              fontWeight: FontWeight.w400,
                              fontSize: 12
                            ),
                          ),
                          
                          
                        ],
                      )
                    ],
                  ),
                ],
              );
  }
}