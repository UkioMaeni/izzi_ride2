import 'package:flutter/material.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/preview_create/components/preview_data.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/preview_create/components/preview_location.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/preview_create/components/preview_time.dart';

class PreviewCreate extends StatefulWidget {
  const PreviewCreate({super.key});

  @override
  State<PreviewCreate> createState() => _PreviewCreateState();
}

class _PreviewCreateState extends State<PreviewCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child:  Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(left: 36),
                        height: 50,
                        alignment: Alignment.centerLeft,
                        child: R.SVG.NavigationBackIcon,
                      ),
                      
                  ),
                  SizedBox(height: 44,),
                   Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(),
                          Text(
                            "Ride information",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontFamily: BrandFontFamily.platform,
                              fontSize: 32,
                              color: BrandColor.black,
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          SizedBox(height: 32,),
                          PreviewLocation(),
                          //R.SVG.DottedLine,
                          PreviewData(),
                          PreviewTime(),
                          SizedBox(height: 24,),
                          UIButton(
                            label: "Done"
                          ),
                          SizedBox(height: 44,),
                        ],
                      ),
                    
                  ),
                  
                ],
              ),
            ),
          
        
      ),
    );
  }
}