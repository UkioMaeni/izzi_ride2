part of 'app_information_bloc.dart';




class AppInformationState {
  
  bool isGetLoadedRequiredServices=true;
  int initialTabPage = 0;
  AppInformationState();

  static  AppInformationState empty(){
    return AppInformationState();
  }
  copyWith({
    bool? isGetLoadedRequiredServices,
    int? initialTabPage
  }){
    return AppInformationState(
      
    )..isGetLoadedRequiredServices=isGetLoadedRequiredServices??this.isGetLoadedRequiredServices
    ..initialTabPage=initialTabPage??this.initialTabPage;
  }

}