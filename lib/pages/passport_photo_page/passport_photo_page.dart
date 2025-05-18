import 'dart:developer';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/app_information_bloc/app_information_bloc.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_preview_scene.dart';
import 'package:permission_handler/permission_handler.dart';


class PassportPhotoPage extends StatefulWidget {
  const PassportPhotoPage({super.key});

  @override
  State<PassportPhotoPage> createState() => _PassportPhotoPageState();
}

class _PassportPhotoPageState extends State<PassportPhotoPage> {

  final ImagePicker picker = ImagePicker();


  Uint8List? photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: Builder(
        builder: (context) {
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
                     "Take a photo of your identity document using the sample",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 32,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  // if(photoSceneType==PhotoSceneType.car) SizedBox(height: 8,),
                  // if(photoSceneType==PhotoSceneType.car) Text(
                  //   h2,
                  //   style: TextStyle(
                  //     fontFamily: BrandFontFamily.platform,
                  //     fontSize: 16,
                  //     color: BrandColor.black,
                  //     fontWeight: FontWeight.w400
                  //   ),
                  // ),
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
                  SizedBox(height: 50,),
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: MediaQuery.of(context).size.height*0.4,
                        child: Builder(
                          builder: (context) {
                            if(photo!=null){
                              return Image.memory(photo!,fit: BoxFit.contain,);
                            }
                            return Image.asset("assets/image/sample/sample_passport.png");
                          }
                        )
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox()
                  ),
                  Builder(
                    builder: (context) {
                      if(photo==null){
                        return UIButton(
                          label: "Take a pictures",
                          onTap: takePictures,
                          margin: EdgeInsets.symmetric(horizontal:47.5 ),
                        );
                      }else{
                        return Column(
                          children: [
                            UIButton(
                              label: "Submit for review",
                              onFuture: submitForReview,
                              margin: EdgeInsets.symmetric(horizontal:47.5 ),
                            ),
                            if(!sending)
                            UIButton(
                              height: 55,
                              onTap: takePictures,
                              label: "Retake a pictures",
                              margin: EdgeInsets.symmetric(horizontal:47.5 ),
                              reverse: true,
                            ),
                          ],
                        );
                      }
                      
                    }
                  ),
                  // UIButton(
                  //   height: 55,
                  //   onTap: choosePictures,
                  //   label: "Choose a picture",
                  //   margin: EdgeInsets.symmetric(horizontal:47.5 ),
                  //   reverse: true,
                  // ),
                  SizedBox(height: 40,)
              ],
            ),
          );
        }
      ),
    );
  }

  bool sending=false;

  Future<void> submitForReview()async{
    if(sending) return;
    setState(() { sending=true; });
    
    final formData = FormData();
    formData.files.add(MapEntry("file", MultipartFile.fromBytes(photo!,filename: "image",)));
    formData.fields.add(MapEntry("file_type", "passport"));
    final result = await UserHttp.I.uploadPhoto(formData);
    if(result is CustomResponse<String>){
      final setPhotoResult=await UserHttp.I.sendUserPassportInReview([result.data]);
      if(setPhotoResult is CustomResponse<bool>){
        
        return toMainPage();
      }
    }
    if(mounted){
      setState(() { sending=false;});
    }
  }


  toMainPage(){
    context.read<AppInformationBloc>().add(AppInformationSetIalTabPage(page: 4));
    context.read<AppInformationBloc>().add(AppInformationSetRequridedLoadServices(isRequired: false));
    context.replaceNamed(RoutesName.main);
  }

  takePictures()async{
    XFile? xFile= await picker.pickImage(source: ImageSource.camera,imageQuality:100 );
    if(xFile!=null){
      photo=await xFile.readAsBytes();
      setState(() {});
    }
  }

  // toPreviewScene(Uint8List file){
  //   final photoSceneType= context.read<PhotoAddBloc>().state.photoSceneType;
  //   if(photoSceneType==PhotoSceneType.user){
  //     context.read<PhotoAddBloc>().add(PhotoAddSetProfileTempPhoto(file:file ));
  //   }else{
  //     context.read<PhotoAddBloc>().add(PhotoAddSetCarTempPhoto(file:file ));
  //   }
  //   context.goNamed(RoutesName.addPhotoPagePreview);
  //   //Navigator.push(context,MaterialPageRoute(builder: (context) => PhotoPreviewScene(),));
  // }

  

}