import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/app_information_bloc/app_information_bloc.dart';
import 'package:izzi_ride_2/core/bloc/car_bloc/car_bloc.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_scene.dart';

class PhotoPreviewScene extends StatefulWidget {
  const PhotoPreviewScene({super.key});

  @override
  State<PhotoPreviewScene> createState() => _PhotoPreviewSceneState();
}

class _PhotoPreviewSceneState extends State<PhotoPreviewScene> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandColor.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: BrandColor.white,
      ),
      body: Column(
        children: [
          NavBar(

          ),
          SizedBox(height: 26,),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(64, 64, 64, 0.82)
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Builder(
                    builder: (context){
                      Uint8List file;
                      final photoSceneType= context.read<PhotoAddBloc>().state.photoSceneType;
                      if(photoSceneType==PhotoSceneType.user){
                        file = context.read<PhotoAddBloc>().state.photoTempUser!;
                      }else{
                        file = context.read<PhotoAddBloc>().state.photoTempCar!;
                      }
                      return Stack(
                        children: [
                          Image.memory(file),
                          Positioned(
                            left: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 43,
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(125)
                              ),
                            )
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              width: 43,
                              decoration: BoxDecoration(
                                color: Colors.black.withAlpha(125)
                              ),
                            )
                          )
                        ],
                      );
                    }
                  ),
                  
                ],
              ),
            )
          ),
          SizedBox(height: 63,),
          UIButton(
            label: "Save",
            width: 278,
            onFuture: loadPhoto,
          ),
          SizedBox(height: 64,),
        ],
      ),
    );
  }


  Future<void> loadPhoto()async{
    final formData=FormData();
    final photoSceneType= context.read<PhotoAddBloc>().state.photoSceneType;
    String fileType= photoSceneType==PhotoSceneType.user?"avatar":"car_photo";
    formData.fields.add(MapEntry("file_type", fileType));
    Uint8List file;
    if(photoSceneType==PhotoSceneType.user){
      file = context.read<PhotoAddBloc>().state.photoTempUser!;
    }else{
      file = context.read<PhotoAddBloc>().state.photoTempCar!;
    }
    formData.files.add(MapEntry("file", MultipartFile.fromBytes(file,filename: "image",)),);
    final result = await UserHttp.I.uploadPhoto(formData);
    if(result is CustomResponse<String>){
       final setPhotoResult=await UserHttp.I.setUserPhoto(result.data);
       if(setPhotoResult is CustomResponse<bool>){
        print("succes");
         return toMainPage();
       }
    }else{
      //TODO error
    }
  }

  toMainPage(){
    context.read<AppInformationBloc>().add(AppInformationSetIalTabPage(page: 4));
    context.read<AppInformationBloc>().add(AppInformationSetRequridedLoadServices(isRequired: false));
    context.replaceNamed(RoutesName.main);
  }

}