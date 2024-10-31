import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class SVG_R {
  Widget get NavigationBackIcon => SvgPicture.asset("assets/svg/navigation/navigation_back.svg");
  Widget get GeolocationIconBlack69 => SvgPicture.asset("assets/svg/UI/geo.svg",color: BrandColor.black,);
  Widget get ChevronRight => SvgPicture.asset("assets/svg/UI/chevron_right.svg");
  Widget get ChevronRightBlack => SvgPicture.asset("assets/svg/UI/chevron_right.svg",color: BrandColor.black,);
  Widget get SelectedAdditionalGrey => SvgPicture.asset("assets/svg/UI/selected_additional.svg",color: BrandColor.grey167,);
  Widget get SelectedAdditionalGreen => SvgPicture.asset("assets/svg/UI/selected_additional.svg",color: BrandColor.green,);
  Widget get PriceMinus => SvgPicture.asset("assets/svg/create_ride/price_minus.svg");
  Widget get PricePlus => SvgPicture.asset("assets/svg/create_ride/price_plus.svg");
  Widget get WhiteLocation =>  SvgPicture.asset("assets/svg/interactive/white_location.svg");
  Widget get DottedLine =>  SvgPicture.asset("assets/svg/interactive/dotted_line.svg");
}

