import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/tools/number_formatter.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
class InputWithFlag extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const InputWithFlag({super.key,required this.controller,required this.focusNode});

  @override
  State<InputWithFlag> createState() => _InputWithFlagState();
}

class _InputWithFlagState extends State<InputWithFlag> {

  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: BrandColor.grey244,
        border: Border.all(
          width: 1,
          color: BrandColor.grey227
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 2.5,top: 2.5,bottom: 2.5),
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: BrandColor.grey214,
              borderRadius: BorderRadius.circular(10)
            ),
            padding: EdgeInsets.all(7.5),
            child: SvgPicture.asset("assets/svg/country/usa.svg")
          ),
          SizedBox(width: 16,),
          Expanded(
            child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: TextField(
                        focusNode: widget.focusNode,
                        controller:widget.controller,
                        maxLength: 16,
                        textInputAction: TextInputAction.done,
                        
                        style:const  TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            
                        ),
                        keyboardType: TextInputType.phone,
                        decoration:const  InputDecoration(
                          border:InputBorder.none,
                          counterText: ""
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                         
                          
                        ],
                        
                        onChanged: (value) =>{
                          setState((){
                            
                          })
                        },
                      )
            ),
          ),
        ],
      ),
    );
  }
}