import 'dart:developer';

import 'package:flutter/material.dart';
//import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/user_photo.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_scene.dart';
import 'package:permission_handler/permission_handler.dart';

class UserInformation extends StatelessWidget {
  final String fullName;
  final bool isVerify;
  final double rate;
  final String? photoUri;
  final int userId;
  final bool isView;
  const UserInformation({super.key,required this.fullName,required this.isVerify,required this.rate,required this.photoUri,required this.userId,this.isView=true});
  static UserInformation withoutView({required String  fullName,required bool isVerify,required double rate,required String? photoUri,required int userId}){
    return UserInformation(fullName: fullName,isVerify: isVerify,photoUri: photoUri,rate: rate,userId: userId,isView: false,);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                      // if(photoUri==null){
                      //   return defaultUserPhoto(context);
                      // }
                      // String url=AppConfig.photoUrl+photoUri!;
                      // log(url);
                      // String? accessToken = GetIt.I.get<TokenInterface>().accessToken;
                      // log("Bearer "+(accessToken??""));
                      // if(photoUri!.contains("http")){
                      //   return Image.network(
                      //     photoUri!,
                      //     errorBuilder: (context, error, stackTrace) {
                      //       log("Photo ava error");
                      //       log(error.toString());
                      //       return defaultUserPhoto(context);
                      //     },
                      //   );
                      // }
                      return UIUserPhoto(url: photoUri,size: Size(101, 101),);
                      // return Image.network(
                      //   url,
                      //   headers: {
                          
                      //     "Authorization":"Bearer "+(accessToken??""),
                      //   },
                      //   errorBuilder: (context, error, stackTrace) {
                      //     log("Photo ava error");
                      //     log(error.toString());
                      //     return defaultUserPhoto(context);
                      //   },
                      // );
                    }
                  ),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
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
                        SizedBox(width: 5,),
                        if(isVerify) SvgPicture.asset("assets/svg/profile/verify.svg",width: 12,height: 12,)
                      ],
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
                        
                      ],
                    ),
                    SizedBox(height: 8,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: BrandColor.grey227,
                            borderRadius: BorderRadius.circular(9)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                  "0 Trips",
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    color: BrandColor.black69,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(width: 5,),
                                R.SVG.StarIcon
                            ],
                          ),
                        ),
                        SizedBox(width: 16,),
                        Container(
                          decoration: BoxDecoration(
                            color: BrandColor.grey227,
                            borderRadius: BorderRadius.circular(9)
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Text(
                                  rate.toString(),
                                  style: TextStyle(
                                    fontFamily: BrandFontFamily.platform,
                                    color: BrandColor.black69,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12
                                  ),
                                ),
                                SizedBox(width: 5,),
                                R.SVG.StarIcon
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox.shrink()),
                        
                      ],
                    ),
                    
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
                if(isView) GestureDetector(
                      onTap: () async{
                        //final me = context.read<UserMeBloc>().state.me;
                        //context.pushNamed(RoutesName.profileView, extra: {"userId":userId,"user":me});

                        
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: BrandColor.blue,
                          ),
                          borderRadius: BorderRadius.circular(12)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                        child: Text(
                          "View as client",
                          style: TextStyle(
                            fontFamily: BrandFontFamily.platform,
                            color: BrandColor.blue,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                          ),
                        ),
                      ),
                    ),
                    //Divider(),
      ],
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