part of 'photo_add_bloc.dart';




class PhotoAddState {

  Uint8List? photoTempCar;
  Uint8List? photoTempUser;
  PhotoSceneType photoSceneType;
  PhotoAddState({
    required this.photoSceneType
  });

  static  PhotoAddState empty(){
    return PhotoAddState(
      photoSceneType: PhotoSceneType.user
    );
  }
  copyWith({
      List<CarItem>? cars,
      bool? requsted,
      PhotoSceneType? photoSceneType
    }){
    return PhotoAddState(
      photoSceneType: photoSceneType??this.photoSceneType
    );
  }

}