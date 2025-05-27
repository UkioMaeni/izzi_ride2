part of 'app_information_bloc.dart';

abstract class AppInformationEvent{
  const AppInformationEvent();
}





class AppInformationSetRequridedLoadServices extends AppInformationEvent{
  final bool isRequired;
  const AppInformationSetRequridedLoadServices({required this.isRequired});
}

class AppInformationSetIalTabPage extends AppInformationEvent{
  final int page;
  const AppInformationSetIalTabPage({required this.page});
}
class AppInformation_RESET_DATA extends AppInformationEvent{
  const AppInformation_RESET_DATA();
}