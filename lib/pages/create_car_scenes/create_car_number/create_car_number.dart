import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';

class CreateCarNumber extends StatefulWidget {
  const CreateCarNumber({super.key});

  @override
  State<CreateCarNumber> createState() => _CreateCarNumberState();
}

class _CreateCarNumberState extends State<CreateCarNumber> {


  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isFocused=false;
  String errorMessage="";


  @override
  void initState() {
    focusNode.addListener(focusListener);
    super.initState();
  }

  void focusListener(){
    if(focusNode.hasFocus){
      isFocused=true;
    }else{
      isFocused=false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }


  saveNumber(){
    if(textEditingController.text.isEmpty){
      setState(() {
        errorMessage="Please enter a valid license plate number";
      });
      return;
    }
    context.read<CreateCarBloc>().add(CreateCarSelectCarNumber(carNumber: textEditingController.text));
    context.goNamed(RoutesName.createCarYear);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          NavBar(),
          SizedBox(height: 54,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(),
                Text(
                  "What's your license\nplate number?",
                  style: TextStyle(
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 32,
                    color: BrandColor.black,
                    fontWeight: FontWeight.w700
                  ),
                ),
                SizedBox(height: 24,),
                Container(
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: BrandColor.grey244,
                    border: Border.all(
                      color: errorMessage.isNotEmpty?BrandColor.red : isFocused?BrandColor.blue:BrandColor.grey214,
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              errorMessage="";
                            });
                          },
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "ABC-1234",
                            hintStyle: TextStyle(
                              color: BrandColor.grey217,
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              fontFamily: "SF"
                            )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if(errorMessage.isNotEmpty)
                Column(
                  children: [
                    SizedBox(height: 8,),
                    Text(
                      errorMessage,
                      style: TextStyle(
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 12,
                        color: BrandColor.red,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24,),
                Align(
                  alignment: Alignment.center,
                  child: UIButton(
                    label: "Save",
                    width: 278,
                    onTap: saveNumber,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}