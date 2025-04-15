part of 'photo_add_bloc.dart';

abstract class PhotoAddEvent{
  const PhotoAddEvent();
}

enum Scene{
  initial,
  fromInput,
  fromMap,
  toInput,
  toMap,
  selectDate,
  selectTime,
  selectCar,
  additional
}



class PhotoAddSetProfileTempPhoto extends PhotoAddEvent{
  final Uint8List file;
  const PhotoAddSetProfileTempPhoto({required this.file});
}
class PhotoAddSetCarTempPhoto extends PhotoAddEvent{
  final Uint8List file;
  const PhotoAddSetCarTempPhoto({required this.file});
}
class PhotoAddSetphotoSceneType extends PhotoAddEvent{
  final PhotoSceneType photoSceneType ;
  const PhotoAddSetphotoSceneType({required this.photoSceneType});
}