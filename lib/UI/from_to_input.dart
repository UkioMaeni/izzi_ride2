import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class FromToInputUI extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const FromToInputUI({
    super.key,
    required this.controller,
    required this.focusNode
  });

  @override
  State<FromToInputUI> createState() => _FromToInputUIState();
}

class _FromToInputUIState extends State<FromToInputUI> {


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
      height: 66,
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
            child: R.SVG.GeolocationIconBlack69,
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: widget.focusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: " From",
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