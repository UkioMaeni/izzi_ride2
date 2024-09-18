
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/registration_bloc/registration_bloc.dart';
import 'package:izzi_ride_2/pages/autorize_phone_page/components/input_with_flag.dart';
import 'package:izzi_ride_2/pages/main_page/main_page.dart';

class AutorizePhonePage extends StatefulWidget {
  const AutorizePhonePage({super.key});

  @override
  State<AutorizePhonePage> createState() => _AutorizePhonePageState();
}

class _AutorizePhonePageState extends State<AutorizePhonePage> {


  final MaskedTextController _numberController = MaskedTextController(mask: '+1 000 000 00 00',text: "+1");
  final FocusNode _focusNode = FocusNode();
   


  Future<void> getCode()async{
    await Future.delayed(Duration(seconds: 2));
    print(_numberController.text);//TODO нужен trim
    setState(() {
      error="Invalid phone number format";
    });
  }

  @override
  void dispose() {
    _numberController.dispose();
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
      body: Column(
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
            padding: const EdgeInsets.symmetric(horizontal:55 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Text(
                    "Enter your\nphone number",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 32,
                      color: BrandColor.black,
                      fontWeight: FontWeight.w700
                    ),
                  ),
                  SizedBox(height: 16,),
                  Text(
                    "The confirmation code will be sent to the specified phone number",
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 16,
                      color: BrandColor.grey167,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 32,),
                  InputWithFlag(
                    controller: _numberController,
                    focusNode: _focusNode,
                    onChange: (p0) {
                      context.read<RegistrationBloc>().add(RegistrationUpdateNumber(phoneNumber: p0));
                    },
                  ),
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
                  SizedBox(height: 32,),
                  UIButton(label: "Get code",margin: EdgeInsets.symmetric(horizontal: 20),onFuture: getCode),
                  UIButton(height: 55,reverse: true, label: "Skip",margin: EdgeInsets.symmetric(horizontal: 20),onTap: ()=>Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => MainPage(),),(route) => false,),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}