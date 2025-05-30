import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/models/settings_title_model.dart';

class SettingsTitle extends StatelessWidget {
  final EdgeInsets padding;
  final SettingsTitleModel settingsTitleModel;
  const SettingsTitle({super.key,required this.settingsTitleModel,this.padding=EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(),
          SizedBox(
            height: 26,
            child: Text(
              settingsTitleModel.title,
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 20,
                color:BrandColor.black,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          for(var punkt in settingsTitleModel.punkts)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32,),
              Text(
                punkt.title,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 18,
                  color:BrandColor.black,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 8,),
              Text(
                punkt.subTitle,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 12,
                  color:BrandColor.black,
                  fontWeight: FontWeight.w400
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}