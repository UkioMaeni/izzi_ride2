import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class UITextField extends StatefulWidget {
  final String hintText;
  final Function(String value)? onChanged;
  const UITextField({super.key,required this.hintText,this.onChanged});

  @override
  State<UITextField> createState() => _UITextFieldState();
}

class _UITextFieldState extends State<UITextField> {



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: BrandColor.grey244,
        border: Border.all(
          color: BrandColor.blue
        ),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          SizedBox(width: 12,),
          SvgPicture.asset("assets/svg/UI/geo.svg"),
          SizedBox(width: 10,),
          Expanded(
            child: TextField(
              onChanged:widget.onChanged,
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 20,
                color: BrandColor.black,
                fontWeight: FontWeight.w400
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  fontFamily: "SF",
                  fontSize: 20,
                  color: BrandColor.grey167,
                  fontWeight: FontWeight.w400
                )
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
        ],
      ),
    );
  }
}