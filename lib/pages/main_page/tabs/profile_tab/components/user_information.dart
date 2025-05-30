import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_scene.dart';

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
          ClipRRect(
            borderRadius: BorderRadius.circular(50.5),
            child: SizedBox(
              width: 101,
              height: 101,
              child: Builder(
                builder: (context) {
                  if(photoUri==null){
                    return defaultUserPhoto(context);
                  }
                  String url=AppConfig.photoUrl+photoUri!;
                  log(url);
                  String? accessToken = GetIt.I.get<TokenInterface>().accessToken;
                  log("Bearer "+(accessToken??""));
                  if(photoUri!.contains("http")){
                    return Image.network(
                      photoUri!,
                      errorBuilder: (context, error, stackTrace) {
                        log("Photo ava error");
                        log(error.toString());
                        return defaultUserPhoto(context);
                      },
                    );
                  }
                  return Image.network(
                    url,
                    headers: {
                      
                      "Authorization":"Bearer "+(accessToken??""),
                    },
                    errorBuilder: (context, error, stackTrace) {
                      log("Photo ava error");
                      log(error.toString());
                      return defaultUserPhoto(context);
                    },
                  );
                }
              ),
            ),
          ),
          SizedBox(width: 16,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                fullName,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  color: BrandColor.black69,
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
                      color: BrandColor.black69,
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

  Widget defaultUserPhoto(BuildContext context){
    return GestureDetector(
        onTap:(){
          context.read<PhotoAddBloc>().add(PhotoAddSetphotoSceneType(photoSceneType: PhotoSceneType.user));
          context.goNamed(RoutesName.addPhotoPage);
        },
        child: SvgPicture.asset("assets/svg/profile/user_not_photo.svg")
      );
  }

}