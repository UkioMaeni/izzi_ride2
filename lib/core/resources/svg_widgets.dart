// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class SVG_R {
  Widget get NavigationBackIcon => SvgPicture.asset("assets/svg/navigation/navigation_back.svg");
  Widget get LightIcon => SvgPicture.asset("assets/svg/UI/light.svg",);
  Widget get LightIcon_White => SvgPicture.asset("assets/svg/UI/light.svg",color: BrandColor.white,);
  Widget get GeolocationIconBlack69 => SvgPicture.asset("assets/svg/UI/geo.svg",color: BrandColor.black69,);
  Widget get ChevronRight => SvgPicture.asset("assets/svg/UI/chevron_right.svg");
  Widget get ChevronRightBlack => SvgPicture.asset("assets/svg/UI/chevron_right.svg",color: BrandColor.black69,);
  Widget get SelectedAdditionalGrey => SvgPicture.asset("assets/svg/UI/selected_additional.svg",color: BrandColor.grey167,);
  Widget get SelectedAdditionalGreen => SvgPicture.asset("assets/svg/UI/selected_additional.svg",color: BrandColor.green,);
  Widget get PriceMinus => SvgPicture.asset("assets/svg/create_ride/price_minus.svg");
  Widget get PricePlus => SvgPicture.asset("assets/svg/create_ride/price_plus.svg");
  Widget get WhiteLocation =>  SvgPicture.asset("assets/svg/interactive/white_location.svg");
  Widget get DottedLine =>  SvgPicture.asset("assets/svg/interactive/dotted_line.svg");
  Widget get SelectedCarIcon =>  SvgPicture.asset("assets/svg/create_ride/selected.svg");
  Widget get DoneCreateRideIcon =>  SvgPicture.asset("assets/svg/create_ride/done_create.svg");
  Widget get SearchLocation =>  SvgPicture.asset("assets/svg/search/location.svg");
  Widget get MessageStatusWait =>  Icon(Icons.schedule,color: BrandColor.white,);
  Widget get MessageStatusRead =>  SvgPicture.asset("assets/svg/messages/mess_status_read.svg");
  Widget get MessageStatusSend =>  Icon(Icons.check,color: BrandColor.white,);
  Widget get MessageDottedLine =>  SvgPicture.asset("assets/svg/messages/dotted_line.svg");
  Widget get MessageSendingInactiveIcon =>  SvgPicture.asset("assets/svg/messages/message_sending_inactive_icon.svg");
  Widget get MessageSendingActiveIcon =>  SvgPicture.asset("assets/svg/messages/message_sending_active_icon.svg");
  Widget get BellIcon =>  SvgPicture.asset("assets/svg/UI/bell.svg");
  Widget get SettingsIcon =>  SvgPicture.asset("assets/svg/profile/settings.svg");
  Widget get PendingStatusIcon =>  SvgPicture.asset("assets/svg/UI/pending_status.svg");
  Widget get StarIcon =>  SvgPicture.asset("assets/svg/profile/star.svg");
  //preferenses
  Widget get PreferenseChildSeatsOFF =>  SvgPicture.asset("assets/svg/preferenses/child_seats_off.svg");
  Widget get PreferenseChildSeatsON =>  SvgPicture.asset("assets/svg/preferenses/child_seats_on.svg");
  Widget get PreferenseLuggageOFF =>  SvgPicture.asset("assets/svg/preferenses/luggage_off.svg");
  Widget get PreferenseLuggageON =>  SvgPicture.asset("assets/svg/preferenses/luggage_on.svg");
  Widget get PreferenseSmokeOFF =>  SvgPicture.asset("assets/svg/preferenses/smoke_off.svg");
  Widget get PreferenseSmokeON =>  SvgPicture.asset("assets/svg/preferenses/smoke_on.svg");
  Widget get PreferenseAnimalOFF =>  SvgPicture.asset("assets/svg/preferenses/animal_off.svg");
  Widget get PreferenseAnimalON =>  SvgPicture.asset("assets/svg/preferenses/animal_on.svg");
}

