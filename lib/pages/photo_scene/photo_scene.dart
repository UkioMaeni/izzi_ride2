import 'dart:developer';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_preview_scene.dart';
import 'package:permission_handler/permission_handler.dart';

enum PhotoSceneType{
  car,user
}

class PhotoScenePage extends StatefulWidget {
  const PhotoScenePage({super.key});

  @override
  State<PhotoScenePage> createState() => _PhotoScenePageState();
}

class _PhotoScenePageState extends State<PhotoScenePage> {

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final photoSceneType= context.read<PhotoAddBloc>().state.photoSceneType;
    String h1=photoSceneType==PhotoSceneType.car?"Add a Photo of\nYour Car":"Take off sunglasses,\nlook ahead, be alone."; 
    String h2=photoSceneType==PhotoSceneType.car?"A photo of your car helps clarify its details and makes your profile more reliable.":""; 
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Builder(
        builder: (context) {
          // if(openedCamera){
          //   return Stack(
          //     alignment: Alignment.bottomCenter,
          //       children: [
          //         SizedBox(
          //           height: MediaQuery.of(context).size.height,
          //           child: CameraPreview(controller)
          //         ),
          //         Positioned(
          //           bottom: 40,
          //           child: GestureDetector(
          //             onTap: () async{
          //               final result= await controller.takePicture();
          //               print(result);
          //               await controller.pausePreview();
          //               setState(() {
          //                 openedCamera=false;
          //               });
          //             },
          //             child: Container(
          //               height: 50,
          //               width: 50,
          //               color: Colors.red,
          //             ),
          //           )
          //         )
          //       ],
          //     );
          // }
          return Padding(
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
                      color: BrandColor.black69,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  if(photoSceneType==PhotoSceneType.car) SizedBox(height: 8,),
                  if(photoSceneType==PhotoSceneType.car) Text(
                    h2,
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
                  Expanded(
                    child: SizedBox()
                  ),
                  UIButton(
                    label: "Take a pictures",
                    onTap: takePictures,
                    margin: EdgeInsets.symmetric(horizontal:47.5 ),
                  ),
                  UIButton(
                    height: 55,
                    onTap: choosePictures,
                    label: "Choose a picture",
                    margin: EdgeInsets.symmetric(horizontal:47.5 ),
                    reverse: true,
                  ),
                  SizedBox(height: 52,)
              ],
            ),
          );
        }
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
    
    
    XFile? xFile= await picker.pickImage(source: ImageSource.camera,imageQuality:100 );
    if(xFile!=null){
      toPreviewScene(await xFile.readAsBytes());
    }
  }

  toPreviewScene(Uint8List file){
    final photoSceneType= context.read<PhotoAddBloc>().state.photoSceneType;
    if(photoSceneType==PhotoSceneType.user){
      context.read<PhotoAddBloc>().add(PhotoAddSetProfileTempPhoto(file:file ));
    }else{
      context.read<PhotoAddBloc>().add(PhotoAddSetCarTempPhoto(file:file ));
    }
    context.goNamed(RoutesName.addPhotoPagePreview);
    //Navigator.push(context,MaterialPageRoute(builder: (context) => PhotoPreviewScene(),));
  }

//   late CameraController controller;

//   late List<CameraDescription> _cameras;

//   _initializeCameraController(CameraDescription desription){
    
//   }

//   Future<bool> _initCamera()async{
//     try {
//       await Permission.camera.request();
//       var status = await Permission.camera.status;
//       if (status.isDenied) {
//         return false;
//       }
//       _cameras = await availableCameras();
//       controller = CameraController(_cameras[0], ResolutionPreset.high,fps: 60);
//       await controller.initialize();
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//   final CameraController? cameraController = controller;

//   // App state changed before we got the chance to initialize.
//   if (cameraController == null || !cameraController.value.isInitialized) {
//     return;
//   }

//   if (state == AppLifecycleState.inactive) {
//     cameraController.dispose();
//   } else if (state == AppLifecycleState.resumed) {
//     _initializeCameraController(cameraController.description);
//   }
// }

  

}