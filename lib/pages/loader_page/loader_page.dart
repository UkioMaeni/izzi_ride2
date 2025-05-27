

import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/localization_bloc/localization_bloc.dart';
import 'package:izzi_ride_2/core/interfaces/app_info_interface.dart';
import 'package:izzi_ride_2/core/interfaces/token_interface.dart';
import 'package:izzi_ride_2/core/models/token.dart';
import 'package:izzi_ride_2/core/resources/image_widgets.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/services/app_info-service.dart';
import 'package:izzi_ride_2/pages/auth_page/auth_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';
import 'package:url_launcher/url_launcher.dart';

class LoaderPage extends StatefulWidget{
  const LoaderPage({super.key});

  @override
  State<LoaderPage> createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {

double _progressValue=0.0;

  nextStep(){
    setState(() {
      _progressValue+=0.1;
    });
  }
  fullStep(){
    if(mounted){
      setState(() {
        _progressValue=1.0;
      });
    }
    
  }

  int code=0;




  initializeService(BuildContext context)async{
    
    nextStep();
    //check app version
    final info= GetIt.I.get<AppInfoInterface>(); 
    await info.getAppVersion();
    nextStep();
    await Future.delayed(Duration(seconds: 2));
    nextStep();
    await auth(context);
    fullStep();
  
  
  }

  Future<void> auth(BuildContext context)async{
     final tokenService= GetIt.I.get<TokenInterface>();
    final resultREfreshing = await tokenService.refreshingToken();
    String result=resultREfreshing.data;
    if(result=="new"){
      return context.goNamed(RoutesName.initialUserData);
    }
    inspect(result);
    if(result=="version_conflict"){
      setState(() {
        code=1;
      });
      await showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("Update require"),
          content: Text("we have launcher a new and improved app. Please update to continue ussing the app."),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text("Update now"),
              onPressed: ()async {
                 Uri  url =Uri.parse('https://apps.apple.com/us/app/izzi-ride/id6449208978') ; // Замените на свою ссылку в App Store
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  throw 'Could not launch $url';
                }

          },
            )
          ],
        );
      },
      );
      return;
    }
    if(result=="error"){
      context.goNamed(RoutesName.auth);
      
      //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => AuthPage(),) , (route) => false);
      return;
    }
    if(result=="no_token"){
      print("there");
      
      context.goNamed(RoutesName.auth);
      //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => AuthPage(),) , (route) => false);
      return;
    }
    //Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainPage(),) , (route) => false);
    context.goNamed(RoutesName.main);
    // if(result=="error"){
    //   //userRepository.isAuth=false;
    //   setState(() {
    //     code=2;
    //   });
    //   //await FirstWelcome().clearSharedPreferences();
    //   setState(() {
    //     code=3;
    //   });
    //   //int result = await FirstWelcome().getWelocme();
    //   setState(() {
    //     code=4;
    //   });
    //   if(result==0){
    //     print("goOnboard");
    //     Navigator.pushNamedAndRemoveUntil(context, "/onboard", (route) => false);
    //   }else{
    //     print("goReg");
    //     Navigator.pushNamedAndRemoveUntil(context, "/reg", (route) => false);
    //   }
      
    // }
    
  }


  goAuthPage(){
    
  }

@override
  void initState() {
   // FirstWelcome().setWelcome();
    initializeService(context);
    super.initState();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        bottomOpacity: 0,
        elevation: 0,
        
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          R.Image.loaderImage,
          SizedBox(height: 80,),
          Builder(
            builder: (context) {
              final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState).localeState;
              return Text(
                state.loaderWelcome,
                style: TextStyle(
                  color: BrandColor.black69,
                  fontFamily: "SF",
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              );
            }
          ),
          SizedBox(height: 16,),
          Builder(
            builder: (context) {
              final state = (context.watch<LocalizationBloc>().state as LocalizationLocaleState).localeState;
              return Text(
                state.loaderOther,
                style: TextStyle(
                  color: Color.fromRGBO(177, 178, 179, 1),
                  fontFamily: "SF",
                  fontSize: 18,
                  fontWeight: FontWeight.w400
                ),
                textAlign: TextAlign.center,
              );
            }
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 68.75,
              left: 38,
              right: 38,
              top: 108.75
            ),
            child: Container(
              width: double.infinity,
              height: 10.5,
              decoration: BoxDecoration(
                color: Color.fromRGBO(58, 121, 215, 0.24),
                borderRadius: BorderRadius.circular(7)
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: _progressValue,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: code==0? Color.fromRGBO(58, 121, 215, 1):code==1?Color.fromRGBO(170, 22, 56, 1) :code==2?Color.fromRGBO(61, 199, 231, 1):code==3?Color.fromRGBO(19, 225, 194, 1):Color.fromRGBO(13, 227, 134, 1)
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      )
    );
  }
}