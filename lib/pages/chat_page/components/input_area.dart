import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class InputArea extends StatefulWidget {
  final Function(String message) sendMessage;
  const InputArea({super.key,required this.sendMessage});

  @override
  State<InputArea> createState() => _InputAreaState();
}

class _InputAreaState extends State<InputArea> {

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(focusNodeListener);
    super.initState();
  }

  bool isFocused = false;

  focusNodeListener(){
    if(_focusNode.hasFocus){
      isFocused=true;
    }else{
      isFocused=false;
    }
    setState(() {});
  }

  void sendMessage(){
    widget.sendMessage(_textEditingController.text);
    _textEditingController.text="";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isFocused?BrandColor.blue:BrandColor.grey167
        )
      ),
      child: Row(
        children: [
          SizedBox(width: 16,),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              focusNode: _focusNode,
              controller: _textEditingController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Message"
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if(_textEditingController.text.isNotEmpty){
                widget.sendMessage(_textEditingController.text);
              }
            },
            child: Container(
              width: 50,
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  if(_textEditingController.text.isEmpty){
                    return R.SVG.MessageSendingInactiveIcon;
                  }
                  return R.SVG.MessageSendingActiveIcon;
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}