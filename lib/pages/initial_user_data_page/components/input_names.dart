import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class InputNames extends StatefulWidget {
  final String hint;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final bool isError;
  const InputNames({
    super.key,
    required this.hint,
    required this.textEditingController,
    required this.focusNode,
    required this.isError
  });

  @override
  State<InputNames> createState() => _InputNamesState();
}

class _InputNamesState extends State<InputNames> {

  bool isFocused=false;

  @override
  void initState() {
    print("start init");
    widget.focusNode.addListener((){
      print("event");
      if(widget.focusNode.hasFocus){
        isFocused=true;
      }else{
        isFocused=false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: BrandColor.grey244,
        border: Border.all(
          color: widget.isError?BrandColor.red: isFocused?BrandColor.blue:BrandColor.grey227
        )
      ),
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        style: TextStyle(
          fontFamily: BrandFontFamily.platform,
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: BrandColor.black69
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontFamily: BrandFontFamily.platform,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: BrandColor.grey167
          )
        ),
        textCapitalization: TextCapitalization.sentences,
      ),
    );
  }
}