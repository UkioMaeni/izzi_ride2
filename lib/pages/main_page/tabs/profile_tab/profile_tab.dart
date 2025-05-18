import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/tab_header.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/photo_add_bloc/photo_add_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/models/enum_checked_status.dart';
import 'package:izzi_ride_2/pages/photo_scene/photo_scene.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/components/list_item.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/components/list_view_container.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/components/user_information.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  String? photoUri=null;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Builder(
        builder: (context) {
          final userMebloc = context.watch<UserMeBloc>();
          final userMeblocState = userMebloc.state;
          if(userMeblocState.requsted){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(userMeblocState.me==null){
            userMebloc.add(UserMeGetMeInfo());
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          String fullName = userMeblocState.me!.name+" "+userMeblocState.me!.surname;
          bool isVerify = true;
          String? photoUri = userMeblocState.me!.photo;
          double rate = userMeblocState.me!.rate;
          return ListView(
            children: [
              SizedBox(height: 20,),
              UITabHeader(label: "About you"),
              SizedBox(height: 32,),
              UserInformation(fullName: fullName,isVerify: isVerify,photoUri: photoUri,rate: rate,),
              SizedBox(height: 24,),
              ListViewContainer(
                items: [
                  if(photoUri==null)
                  ListItem(
                    icon: SvgPicture.asset("assets/svg/profile/picture.svg"),
                    label: "Add profile picture",
                    status: EnumCheckedStatus.confirmed,
                    onTap: (){
                      context.read<PhotoAddBloc>().add(PhotoAddSetphotoSceneType(photoSceneType: PhotoSceneType.user));
                      context.goNamed(RoutesName.addPhotoPage);
                    },
                  ),
                  ListItem(icon: SvgPicture.asset("assets/svg/profile/personal_details.svg"),label: "Edit personal details",status: EnumCheckedStatus.confirmed,),
                ],
              ),
              SizedBox(height: 24,),
              Builder(
                builder: (context) {
                  //статусы
                  EnumCheckedStatus phoneConfirmed= userMeblocState.me!.phoneConfirmed?EnumCheckedStatus.confirmed:EnumCheckedStatus.unconfirmed;
                  EnumCheckedStatus emailConfirmed= userMeblocState.me!.emailConfirmed?EnumCheckedStatus.confirmed:EnumCheckedStatus.unconfirmed;
                  //bool passportConfirmed=userMeblocState.me!.passportConfirmed;
                  EnumCheckedStatus  passportConfirmed=userMeblocState.me!.passportConfirmed; 
                  EnumCheckedStatus socialMediaConfirmed=EnumCheckedStatus.unconfirmed;
                  //строковые статусы. подтверждено,проверка,не подверждено
                  // EnumCheckedStatus phoneConfirmedString=phoneConfirmed?EListItemStatus.completed:EListItemStatus.required;
                  // EnumCheckedStatus emailConfirmedString=emailConfirmed?EListItemStatus.completed:EListItemStatus.required;
                  // EnumCheckedStatus passportConfirmedString=passportConfirmed?EListItemStatus.completed:EListItemStatus.required;
                  // EnumCheckedStatus socialMediaConfirmedString=socialMediaConfirmed?EnumCheckedStatus.completed:EListItemStatus.required;
                  return ListViewContainer(
                    title: "Verify your profile",
                    items: [
                      ListItem(
                        icon: SvgPicture.asset("assets/svg/profile/verify.svg",color:passportConfirmed==EnumCheckedStatus.pending?BrandColor.grey167:null,),
                        label: "Verification Pending",
                        status: passportConfirmed,
                        onTap: () {
                          context.goNamed(RoutesName.addPhotoPassportPage);
                        },
                      ),
                      ListItem(icon: SvgPicture.asset("assets/svg/profile/mail.svg"),label: "Email confirmed",status: emailConfirmed,),
                      ListItem(icon: SvgPicture.asset("assets/svg/profile/phone.svg"),label: "Phone confirmed ",status: phoneConfirmed,),
                      ListItem(icon: SvgPicture.asset("assets/svg/profile/phone.svg"),label: "Social media confirmed",status: socialMediaConfirmed,),
                    ],
                  );
                }
              ),
              SizedBox(height: 24,),
              ListViewContainer(
                title: "Payment card",
                items: [
                  ListItem(
                    icon: SvgPicture.asset("assets/svg/profile/verify.svg"),
                    label: "card: ****0524",
                    status: EnumCheckedStatus.disabled,
                    onTap: () {
                      context.goNamed(RoutesName.paymentProcess);
                    },
                  ),
                  
                ],
              ),
              
              SizedBox(height: 24,),
              ListViewContainer(
                title: "About You(в разработке)",
                items: [
                  ListItem(icon: SvgPicture.asset("assets/svg/profile/verify.svg"),label: "Verify Id",status: EnumCheckedStatus.unconfirmed,),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}