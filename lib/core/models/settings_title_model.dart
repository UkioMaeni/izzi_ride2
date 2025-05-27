class SettingsTitleModel {
   String title;
   List<SettingPunktAction> punkts;
   SettingsTitleModel({
    required this.title,
    this.punkts=const[],
  });
}

class SettingPunktAction{
  String title;
  String subTitle;
  Function()? onTap;
  SettingPunktAction({
    required this.title,
    required this.subTitle,
    this.onTap,
  });
}