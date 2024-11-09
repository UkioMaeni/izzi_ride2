import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/UI/nav_bar.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_car_bloc%20copy/create_car_bloc.dart';

class CreateCarYear extends StatefulWidget {
  const CreateCarYear({super.key});

  @override
  State<CreateCarYear> createState() => _CreateCarYearState();
}

class _CreateCarYearState extends State<CreateCarYear> {

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

  saveYear(){
    if(textEditingController.text.length<4){
      setState(() {
        errorMessage="Please enter a valid year";
      });
      return;
    }
    context.read<CreateCarBloc>().add(CreateCarSelectCarYear(carYear: textEditingController.text));
    context.goNamed(RoutesName.createCarPhoto);
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
                  "When was your\nvehicle’s registered?",
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
                          maxLength: 4,
                          
                          buildCounter: (context, {required currentLength, required isFocused, required maxLength}) {
                            return SizedBox.shrink();
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: 5),
                            border: InputBorder.none,
                            hintText: "2012",
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
                    onTap: saveYear,
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