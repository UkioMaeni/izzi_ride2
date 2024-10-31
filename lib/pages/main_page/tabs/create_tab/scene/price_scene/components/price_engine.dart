import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';
import 'package:izzi_ride_2/core/tools/dollar_formatter.dart';
import 'package:izzi_ride_2/core/tools/number_formatter.dart';

class PriceEngine extends StatefulWidget {
  const PriceEngine({super.key});

  @override
  State<PriceEngine> createState() => _PriceEngineState();
}

class _PriceEngineState extends State<PriceEngine> {

  final FocusNode _focusNode = FocusNode();
  late TextEditingController _textEditingController;


  final int minimalValue = 5;
  final int maximalValue = 999;
  final int iterationValue = 5;
  @override
  void initState() {
    _textEditingController=TextEditingController(text: minimalValue.toString());
    _textEditingController.addListener(textControllerListener);
    _focusNode.addListener(focusNodeListener);
    super.initState();
  }

  void textControllerListener(){
    updatePrice();
    setState(() {});
  }
  void focusNodeListener(){
    if(_focusNode.hasFocus){
      isFocused=true;
    }else{
      if(_textEditingController.text=="0" || _textEditingController.text.isEmpty){
        _textEditingController.text=minimalValue.toString();
      }
      isFocused=false;
    }
    setState(() {});
  }
  bool isFocused=false;

  priceMinus(){
    if(_textEditingController.text.isEmpty) return;
    int parcedPrice = int.parse(_textEditingController.text);
    if(parcedPrice<=minimalValue){
      _textEditingController.text=minimalValue.toString();
    }else{
      parcedPrice-=iterationValue;
      _textEditingController.text=parcedPrice.toString();
    }
  }

  pricePlus(){
    int parcedPrice=0;
    if(_textEditingController.text.isEmpty){
      parcedPrice=5;
    }else{
      parcedPrice = int.parse(_textEditingController.text);
    }
    if(parcedPrice>=maximalValue-iterationValue){
      _textEditingController.text=maximalValue.toString();
    }else{
      parcedPrice+=iterationValue;
      _textEditingController.text=parcedPrice.toString();
    }
  }

  updatePrice(){
    int price;
    if(_textEditingController.text.isEmpty){
      price=0;
    }else{
      price= int.parse(_textEditingController.text);
    }
    context.read<CreateRideBloc>().add(CreateRideEditPrice(price:price));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap:priceMinus,
            child: Container(
              padding: EdgeInsets.only(right: 32),
              alignment: Alignment.centerRight,
              child: R.SVG.PriceMinus
            ),
          )
        ),
        Container(
          width: 180,
          height: 80,
          decoration: BoxDecoration(
            color: BrandColor.grey244,
            border: Border.all(
              color: isFocused?BrandColor.blue:BrandColor.grey227
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Stack(
            children: [
              Align(
                child: Text(
                  "\$"+_textEditingController.text,
                  style: TextStyle(
                    color: BrandColor.black,
                    fontFamily: BrandFontFamily.platform,
                    fontSize: 32,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
              Opacity(
                opacity: 0,
                child: Container(
                  color: Color.fromARGB(121, 170, 123, 119),
                  child: TextField(
                      controller: _textEditingController,
                      focusNode: _focusNode,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        color: BrandColor.black,
                        fontFamily: BrandFontFamily.platform,
                        fontSize: 32,
                        fontWeight: FontWeight.w700
                      ),
                      maxLength: 3,
                      onChanged: (value) {
                        if(value.isNotEmpty&&value.length>1&& value[0]=="0"){
                          _textEditingController.text=_textEditingController.text.substring(1);
                          setState(() {});
                        }
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 15)
                        
                      ),
                      buildCounter: (context, {required currentLength, required isFocused, required maxLength}) => SizedBox(),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                ),
              ),
              
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: pricePlus,
            child: Container(
              padding: EdgeInsets.only(left: 32),
              alignment: Alignment.centerLeft,
              child: R.SVG.PricePlus
            ),
          )
        )
      ],
    );
  }



}