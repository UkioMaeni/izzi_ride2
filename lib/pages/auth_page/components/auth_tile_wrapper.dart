import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/pages/auth_page/components/auth_tile.dart';
import 'package:izzi_ride_2/pages/autorize_phone_page/autorize_phone_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';
import 'package:izzi_ride_2/pages/main_page/photo_scene/photo_scene.dart';

class AuthTileWrapper extends StatefulWidget {
  const AuthTileWrapper({super.key});

  @override
  State<AuthTileWrapper> createState() => _AuthTileWrapperState();
}

class _AuthTileWrapperState extends State<AuthTileWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.only(left: 41,right: 41,bottom: 56,top: 64),
      margin: EdgeInsets.all(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Sign up",
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 20,
                color: BrandColor.black,
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 12,),
            Text(
              "Choose Your Method",
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 18,
                color: BrandColor.grey167,
                fontWeight: FontWeight.w500
              ),
            ),
          SizedBox(height: 24,),
          AuthTile(label: "Continue with Phone",reverse: true,onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => AutorizePhonePage(),)),),
          SizedBox(height: 12,),
          AuthTile(label: "Continue with Google",icon: SvgPicture.asset("assets/svg/brands/google.svg",width: 24,height: 24,),),
          SizedBox(height: 12,),
          AuthTile(label: "Continue with Apple",icon: SvgPicture.asset("assets/svg/brands/apple.svg"),)
        ],
      ),
    );
  }
}