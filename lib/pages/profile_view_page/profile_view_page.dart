import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/app_information_bloc/app_information_bloc.dart';
import 'package:izzi_ride_2/core/bloc/user_me_bloc/user_me_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/enum_checked_status.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/core/models/user_model.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/components/list_item.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/components/list_view_container.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/profile_tab/components/user_information.dart';

class ProfileViewPage extends StatefulWidget {
  final UserModel? user;
  final int userId;
  const ProfileViewPage({super.key,required this.userId,this.user});

  @override
  State<ProfileViewPage> createState() => _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {


  UserModel? user;

  Future<void> getInfo()async{
    if(widget.user!=null){
      user=widget.user;
    }else{
      final result = await UserHttp.I.getUserInfo(widget.userId);
      if(result is CustomResponse<UserModel>){
        user=result.data;
      }
    }
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: BrandColor.white,
      ),
      backgroundColor: BrandColor.white,
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 24),
              child: Icon(Icons.close,size: 40,),
            ),
          ),
          SizedBox(height: 32,),
          Builder(
            builder: (context) {
                  if(user==null){
                      return Expanded(child: Center(child: CircularProgressIndicator()));
                    }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserInformation.withoutView(fullName: user!.name, isVerify: true, rate: user!.rate, photoUri: user!.photo, userId: user!.clienId),
                    SizedBox(height: 24,),
                    Builder(
                      builder: (context) {
                        //статусы
                        EnumCheckedStatus phoneConfirmed= user!.phoneConfirmed?EnumCheckedStatus.confirmed:EnumCheckedStatus.unconfirmed;
                        EnumCheckedStatus emailConfirmed= user!.emailConfirmed?EnumCheckedStatus.confirmed:EnumCheckedStatus.unconfirmed;
                        //bool passportConfirmed=userMeblocState.me!.passportConfirmed;
                        EnumCheckedStatus  passportConfirmed=user!.passportConfirmed; 
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
                            ),
                            ListItem(icon: SvgPicture.asset("assets/svg/profile/mail.svg"),label: "Email confirmed",status: emailConfirmed,),
                            ListItem(icon: SvgPicture.asset("assets/svg/profile/phone.svg"),label: "Phone confirmed ",status: phoneConfirmed,),
                            ListItem(icon: SvgPicture.asset("assets/svg/profile/phone.svg"),label: "Social media confirmed",status: socialMediaConfirmed,),
                          ],
                        );
                      }
                    ),
                    SizedBox(height: 24,),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      "Bio",
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 20,
                        color: BrandColor.black69,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: BrandColor.listViewContainer,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16,horizontal: 12),
                    child: Text(
                      user!.bio.isEmpty?"No information":user!.bio,
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 18,
                        color: BrandColor.black69,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                  ],
                ),
              );
            }
          )
        ],
      ),
    );
  }
}