import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/enum_authorization_type.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/pages/auth_page/components/auth_tile.dart';
import 'package:izzi_ride_2/pages/autorize_phone_page/autorize_phone_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_scene.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthTileWrapper extends StatefulWidget {
  const AuthTileWrapper({super.key});

  @override
  State<AuthTileWrapper> createState() => _AuthTileWrapperState();
}

class _AuthTileWrapperState extends State<AuthTileWrapper> {


  googleAuth()async{
    const List<String> scopes = <String>[
      'email',
    ];
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: scopes,
      serverClientId: "320242355547-a7j0hihcqugj9iub8pce39rhvp07urlc.apps.googleusercontent.com"
      
    );
     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
     final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
     log(googleAuth?.idToken??"");
     CustomResponse result= await UserHttp.I.authorization(AuthorizationType.google, googleAuth?.idToken??"", "");
     log(googleAuth?.accessToken??"");
      print(result);
   if(result is CustomResponse<CustomErrorRepsonse>){
    
   }else if(result is CustomResponse<bool>){
      toMainPage();
   }
  }
  void toMainPage(){
    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage(),), (route) => false,);
    context.pushReplacementNamed(RoutesName.main);
  }
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
                color: BrandColor.black69,
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
          AuthTile(
            label: "Continue with Phone",
            reverse: true,
            onTap:()=> context.goNamed(RoutesName.authPhone),
          ),
          SizedBox(height: 12,),
          AuthTile(
            label: "Continue with Google",
            icon: SvgPicture.asset("assets/svg/brands/google.svg",
              width: 24,
              height: 24,
            ),
            onTap:()=> googleAuth(),
          ),
          SizedBox(height: 12,),
          AuthTile(label: "Continue with Apple",icon: SvgPicture.asset("assets/svg/brands/apple.svg"),)
        ],
      ),
    );
  }
}