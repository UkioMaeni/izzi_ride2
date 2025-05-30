import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:izzi_ride_2/config/app_config.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';

class UIUserPhoto extends StatefulWidget {
  final String url;
  final Size size;
  const UIUserPhoto({super.key,required this.url,this.size=const Size(50, 50)});

  @override
  State<UIUserPhoto> createState() => _UIUserPhotoState();
}

class _UIUserPhotoState extends State<UIUserPhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: BrandColor.blue,
          width: 3
        ),
        borderRadius: BorderRadius.circular((widget.size.width+widget.size.height)/2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular((widget.size.width+widget.size.height)/2),
        child: Container(
          width: widget.size.width,
          height: widget.size.height,
          
          child: Builder(
            builder: (context) {
              String url=AppConfig.photoUrl+widget.url;
                String? accessToken = GetIt.I.get<TokenInterface>().accessToken;
                if(widget.url.contains("http")){
                  return Image.network(
                    widget.url,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      log("Photo ava error");
                      log(error.toString());
                      return SvgPicture.asset("assets/svg/profile/user_not_photo.svg");
                    },
                  );
                }
                return Image.network(
                  url,
                  fit: BoxFit.cover,
                  headers: {
                    
                    "Authorization":"Bearer "+(accessToken??""),
                  },
                  errorBuilder: (context, error, stackTrace) {
          
                    return SvgPicture.asset("assets/svg/profile/user_not_photo.svg");
                  },
                );
            }
          ),
        ),
      ),
    );
  }

  
}