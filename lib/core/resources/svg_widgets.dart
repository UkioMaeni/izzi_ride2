import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class SVG_R {
  Widget get NavigationBackIcon => SvgPicture.asset("assets/svg/navigation/navigation_back.svg");
  Widget get GeolocationIconBlack69 => SvgPicture.asset("assets/svg/UI/geo.svg",color: BrandColor.black,);
  Widget get ChevronRight => SvgPicture.asset("assets/svg/UI/chevron_right.svg");
  Widget get ChevronRightBlack => SvgPicture.asset("assets/svg/UI/chevron_right.svg",color: BrandColor.black,);
}