import 'dart:async';

class Debounce{
   Timer? _timer;
  start(Function() fn){
    _timer=Timer.periodic(
      Duration(milliseconds: 300), 
      (_){
        _timer!.cancel();
        fn();
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