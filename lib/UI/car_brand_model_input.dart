import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class CarBrandModelInputUI extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const CarBrandModelInputUI({
    super.key,
    required this.controller,
    required this.focusNode
  });

  @override
  State<CarBrandModelInputUI> createState() => _CarBrandModelInputUIState();
}

class _CarBrandModelInputUIState extends State<CarBrandModelInputUI> {


    @override
  void initState() {
    widget.focusNode.addListener((){
      if(widget.focusNode.hasFocus){
        isFocused=true;
      }else{
        isFocused=false;
      }
      setState(() {});
    });
    super.initState();
  }

  bool isFocused=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: BrandColor.grey244,
        border: Border.all(
          color: isFocused?BrandColor.blue:BrandColor.grey214,
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            alignment: Alignment.center,
            child: Icon(Icons.search,color: BrandColor.grey227,),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
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
    );
  }
}