import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';

class CreateCarPhoto extends StatefulWidget {
  const CreateCarPhoto({super.key});

  @override
  State<CreateCarPhoto> createState() => _CreateCarPhotoState();
}

class _CreateCarPhotoState extends State<CreateCarPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          NavBar(),
          SizedBox(height: 40,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(),
                  Text(
                    "Add a Photo of\nYour Car",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 32,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "A photo of your car helps clarify its details and makes your profile more reliable.",
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
                  Expanded(child: SizedBox.shrink()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(),
                      UIButton(
                        label: "Take a picture",
                        width: 311,
                      ),
                      SizedBox(height: 16,),
                      UIButton(
                        alternate: true,
                        label: "Choose a picture",
                        width: 311,
                      ),
                      UIButton(
                        reverse: true,
                        label: "Skip",
                        width: 311,
                        onTap: () {
                          context.goNamed(RoutesName.createCarDetails);
                        },
                      ),
                      SizedBox(height: 41,)
                    ],
                  )
                  
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}