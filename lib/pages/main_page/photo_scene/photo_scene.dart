import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';

enum PhotoSceneType{
  car,user
}

class PhotoScenePage extends StatefulWidget {
  final PhotoSceneType photoSceneType;
  const PhotoScenePage({super.key,required this.photoSceneType});

  @override
  State<PhotoScenePage> createState() => _PhotoScenePageState();
}

class _PhotoScenePageState extends State<PhotoScenePage> {
  @override
  Widget build(BuildContext context) {
    String h1=widget.photoSceneType==PhotoSceneType.car?"Add a Photo of\nYour Car":"Take off sunglasses,\nlook ahead, be alone."; 
    String h2=widget.photoSceneType==PhotoSceneType.car?"A photo of your car helps clarify its details and makes your profile more reliable.":""; 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  height: 50,
                  width: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset("assets/svg/photo_scene/back.svg")
                  )
                ),
              )
              
            ),
            SizedBox(height: 47,),
            Text(
                 h1,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 32,
                  color: BrandColor.black,
                  fontWeight: FontWeight.w700
                ),
              ),
              if(widget.photoSceneType==PhotoSceneType.car) SizedBox(height: 8,),
              if(widget.photoSceneType==PhotoSceneType.car) Text(
                h2,
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 16,
                  color: BrandColor.black,
                  fontWeight: FontWeight.w400
                ),
              ),
              SizedBox(height: 8,),
              Text(
                "Maximum file size: 10 MB",
                style: TextStyle(
                  fontFamily: BrandFontFamily.platform,
                  fontSize: 16,
                  color: BrandColor.red,
                  fontWeight: FontWeight.w400
                ),
              ),
              Expanded(
                child: SizedBox()
              ),
              UIButton(
                label: "Take a pictures",
                margin: EdgeInsets.symmetric(horizontal:47.5 ),
              ),
              UIButton(
                height: 55,
                label: "Choose a picture",
                margin: EdgeInsets.symmetric(horizontal:47.5 ),
                reverse: true,
              ),
              SizedBox(height: 52,)
          ],
        ),
      ),
    );
  }
}