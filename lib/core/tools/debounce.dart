import 'dart:async';

class Debounce{
  Duration duration;
  Debounce({required this.duration});
   Timer? _timer;
  start(Function() fn){
    fn();
    _timer=Timer.periodic(
      duration, 
      (_){
        _timer!.cancel();
        
      }
    );
  }
  debounce(Function() fn){
    if(_timer==null){
      start(fn);
    }else{
      _timer!.cancel();
      start(fn);
    }
  }
}