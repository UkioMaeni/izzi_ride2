import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc/create_car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class CreateCarPhoto extends StatefulWidget {
  const CreateCarPhoto({super.key});

  @override
  State<CreateCarPhoto> createState() => _CreateCarPhotoState();
}

class _CreateCarPhotoState extends State<CreateCarPhoto> {

  final ImagePicker picker = ImagePicker();

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
                      color: BrandColor.black69,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 8,),
                  Text(
                    "A photo of your car helps clarify its details and makes your profile more reliable.",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 16,
                      color: BrandColor.black69,
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
                        onTap: takePictures,
                        label: "Take a picture",
                        width: 311,
                      ),
                      SizedBox(height: 16,),
                      UIButton(
                        alternate: true,
                        onTap: choosePictures,
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


  choosePictures()async{
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    if(xFile!=null){
      toPreviewScene(await xFile.readAsBytes());
    }
  }


  takePictures()async{
    
    final permission=  await Permission.camera.request();
    if(permission.isDenied){
      return;
    }
    XFile? xFile= await picker.pickImage(source: ImageSource.camera,imageQuality:100 );
    if(xFile!=null){
      toPreviewScene(await xFile.readAsBytes());
    }
  }

  toPreviewScene(Uint8List file){
    context.read<CreateCarBloc>().add(CreateCarAddPhotos(carPhotos:[file]));
    context.goNamed(RoutesName.createCarDetails);
    
  }

}