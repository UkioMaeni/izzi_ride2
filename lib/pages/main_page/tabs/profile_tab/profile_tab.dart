import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/UI/tab_header.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/pages/main_page/photo_scene/photo_scene.dart';
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
          String photoUri = userMeblocState.me!.photo;
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
                  if(photoUri.isEmpty||!photoUri.contains("http"))ListItem(icon: SvgPicture.asset("assets/svg/profile/picture.svg"),label: "Add profile picture",status: "no",onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) => PhotoScenePage(photoSceneType: PhotoSceneType.user,),)),),
                  ListItem(icon: SvgPicture.asset("assets/svg/profile/personal_details.svg"),label: "Edit personal details",status: "no",),
                ],
              ),
              SizedBox(height: 24,),
              Builder(
                builder: (context) {
                  //статусы
                  bool phoneConfirmed= userMeblocState.me!.phoneConfirmed;
                  bool emailConfirmed= userMeblocState.me!.emailConfirmed;
                  bool passportConfirmed=false;
                  bool socialMediaConfirmed=false;
                  //строковые статусы. подтверждено,проверка,не подверждено
                  String phoneConfirmedString=phoneConfirmed?"completed":"no";
                  String emailConfirmedString=emailConfirmed?"completed":"no";
                  String passportConfirmedString=passportConfirmed?"completed":"no";
                  String socialMediaConfirmedString=socialMediaConfirmed?"completed":"no";
                  return ListViewContainer(
                    title: "Verify your profile",
                    items: [
                      ListItem(icon: SvgPicture.asset("assets/svg/profile/verify.svg"),label: "Verify Id",status: passportConfirmedString,),
                      ListItem(icon: SvgPicture.asset("assets/svg/profile/mail.svg"),label: "Email confirmed",status: emailConfirmedString,),
                      ListItem(icon: SvgPicture.asset("assets/svg/profile/phone.svg"),label: "Phone confirmed ",status: phoneConfirmedString,),
                      ListItem(icon: SvgPicture.asset("assets/svg/profile/phone.svg"),label: "Social media confirmed",status: socialMediaConfirmedString,),
                    ],
                  );
                }
              ),
              SizedBox(height: 24,),
              ListViewContainer(
                title: "About You(в разработке)",
                items: [
                  ListItem(icon: SvgPicture.asset("assets/svg/profile/verify.svg"),label: "Verify Id",status: "completed",),
                  ListItem(icon: SvgPicture.asset("assets/svg/profile/mail.svg"),label: "Verify Id",status: "completed",),
                  ListItem(icon: SvgPicture.asset("assets/svg/profile/phone.svg"),label: "Verify Id",status: "completed",),
                  ListItem(icon: SvgPicture.asset("assets/svg/profile/phone.svg"),label: "Verify Id",status: "completed",),
                ],
              )
            ],
          );
        }
      ),
    );
  }
}