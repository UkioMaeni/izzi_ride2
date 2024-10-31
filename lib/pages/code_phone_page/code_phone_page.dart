
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/registration_bloc/registration_bloc.dart';
import 'package:izzi_ride_2/core/http/user_http.dart';
import 'package:izzi_ride_2/core/models/enum_authorization_type.dart';
import 'package:izzi_ride_2/core/models/response.dart';
import 'package:izzi_ride_2/pages/autorize_phone_page/components/input_with_flag.dart';
import 'package:izzi_ride_2/pages/initial_user_data_page/initial_user_data_page.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';

class CodePhonePage extends StatefulWidget {
  const CodePhonePage({super.key});

  @override
  State<CodePhonePage> createState() => _CodePhonePageState();
}

class _CodePhonePageState extends State<CodePhonePage> {


  final TextEditingController _codeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
   


  get phoneNumber => context.read<RegistrationBloc>().state.phoneNumber;

  Future<void> checkCode()async{
    print("auth");
   CustomResponse result= await  UserHttp().authorization(AuthorizationType.phone, _codeController.text, phoneNumber.replaceAll(" ", "").replaceAll("+", ""));
   print(result);
   if(result is CustomResponse<CustomErrorRepsonse>){
    setState(() {
      enabled=true;
    });
   }else if(result is CustomResponse<bool>){
      bool isClientNew = result.data;
      print(isClientNew);
      if(isClientNew){
         toIniitialUserDataPage();
      }else{
        toMainPage();
      }
   }
  }

  void toMainPage(){
    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MainPage(),), (route) => false,);
    context.pushReplacementNamed(RoutesName.main);
  }
  void toIniitialUserDataPage(){
    //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => InitialUserDataPage(),), (route) => false,);
    context.pushReplacementNamed(RoutesName.initialUserData);
  }
  bool isFocused=false;
  bool enabled=true;
  @override
  void initState() {
    _focusNode.addListener(() {
      if(_focusNode.hasFocus){
        isFocused=true;
      }else{
        isFocused=false;
      }
      setState(() {});
    },);
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String error="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
      ),
      body: BlocProvider(
        create: (context) => RegistrationBloc(),
        child: Builder(
          builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 36),
                    child: SvgPicture.asset("assets/svg/navigation/navigation_back.svg")
                  ),
                ),
                SizedBox(height: 47,),
                Padding(
                  padding: const EdgeInsets.only(left:24,right: 24 ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
                      Text(
                          "Enter the 4-digit code",
                          style: TextStyle(
                            fontFamily: BrandFontFamily.platform,
                            fontSize: 32,
                            color: BrandColor.black,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        SizedBox(height: 16,),
                        Text(
                          "We sent it to ${phoneNumber} by SMS",
                          style: TextStyle(
                            fontFamily: BrandFontFamily.platform,
                            fontSize: 16,
                            color: BrandColor.grey167,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 32,),
                        
                        if(error.isNotEmpty)
                        Column(
                          children: [
                            SizedBox(height: 8,),
                            Text(
                              error,
                              style: TextStyle(
                                fontFamily: BrandFontFamily.platform,
                                fontSize: 12,
                                color: BrandColor.red,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                        input(),
                        SizedBox(height: 32,),
                    ],
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  Widget input(){
    return Container(
      decoration: BoxDecoration(
        color: BrandColor.grey244,
        border: Border.all(
          color: isFocused?BrandColor.blue:BrandColor.grey227
        ),
        borderRadius: BorderRadius.circular(12)
      ),
      alignment: Alignment.center,
      child:  Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                
                children: [
                  Builder(
                    builder: (context) {
                      String text="";
                      if(_codeController.text.length>=1){
                        text=_codeController.text[0];
                      }
                      return Text(
                        text,
                        style: TextStyle(
                          fontFamily: "SF",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      );
                    }
                  ),
                  Container(
                    width: 27.56,
                    decoration: BoxDecoration(
                      
                      border: Border.all(
                        color: _codeController.text.length>=1?Colors.transparent:BrandColor.grey167
                      )
                    ),
                  )
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Builder(
                    builder: (context) {
                      String text="";
                      if(_codeController.text.length>=2){
                        text=_codeController.text[1];
                      }
                      return Text(
                        text,
                        style: TextStyle(
                          fontFamily: "SF",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      );
                    }
                  ),
                  Container(
                    width: 27.56,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _codeController.text.length>=2?Colors.transparent:BrandColor.grey167
                      )
                    ),
                  )
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Builder(
                    builder: (context) {
                      String text="";
                      if(_codeController.text.length>=3){
                        text=_codeController.text[2];
                      }
                      return Text(
                        text,
                        style: TextStyle(
                          fontFamily: "SF",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      );
                    }
                  ),
                  Container(
                    width: 27.56,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _codeController.text.length>=3?Colors.transparent:BrandColor.grey167
                      )
                    ),
                  )
                ],
              ),
              SizedBox(width: 10,),
              Column(
                children: [
                  Builder(
                    builder: (context) {
                      String text="";
                      if(_codeController.text.length>=4){
                        text=_codeController.text[3];
                      }
                      return Text(
                        text,
                        style: TextStyle(
                          fontFamily: "SF",
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      );
                    }
                  ),
                  Container(
                    width: 27.56,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _codeController.text.length>=4?Colors.transparent:BrandColor.grey167
                      )
                    ),
                  )
                ],
              )
            ],
          ),
          
          Opacity(
              opacity: 0,
              child: TextField(
                        enabled: enabled,
                        focusNode: _focusNode,
                        controller:_codeController,
                        maxLength: 4,
                        textInputAction: TextInputAction.done,
                        
                        style:const  TextStyle(
                            fontFamily: "SF",
                            fontWeight: FontWeight.w400,
                            letterSpacing: 27.6,
                            fontSize: 16,
                            
                        ),
                        keyboardType: TextInputType.phone,
                        cursorHeight: 0,
                        decoration:const  InputDecoration(
                          border:InputBorder.none,
                          counterText: "",
                          
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          
                          
                        ],
                        
                        onChanged: (value){
                          
                          if(value.length==4){
                            enabled=false;
                            checkCode();
                          }
                          setState(() {
                          });
                        },
                      ),
            
          ),
        ],
      ),
    );
  }

}