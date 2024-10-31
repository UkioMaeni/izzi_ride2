import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';

class CommentArea extends StatefulWidget {
  final FocusNode focusNode;
  final bool isFocused;
  final Function(String value) onTextChange;
  const CommentArea({super.key,required this.focusNode,required this.onTextChange,required this.isFocused});

  @override
  State<CommentArea> createState() => _CommentAreaState();
}

class _CommentAreaState extends State<CommentArea> {

  

  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Comment on the ride",
            style: TextStyle(
              fontFamily: BrandFontFamily.platform,
              fontSize: 20,
              color: BrandColor.black,
              fontWeight: FontWeight.w400
            ),
          ),
          SizedBox(height: 8,),
          Container(
            height: 127,
            decoration: BoxDecoration(
              color: BrandColor.grey244,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: widget.isFocused?BrandColor.blue:BrandColor.grey227
              )
            ),
            child: TextField(
              focusNode: widget.focusNode,
              onChanged: widget.onTextChange,
              maxLines: 5,
              scrollPadding: EdgeInsets.only(bottom: 244),
              
              decoration: InputDecoration(
                
                border: InputBorder.none
              ),
            ),
          )
      ],
    );
  }
}