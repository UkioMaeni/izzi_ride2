import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class AuthTile extends StatefulWidget {
  final String label;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final bool? reverse;
  final Function()? onTap;
  const AuthTile({super.key,this.icon,required this.label,this.backgroundColor,this.textColor,this.reverse,this.onTap});

  @override
  State<AuthTile> createState() => _AuthTileState();
}

class _AuthTileState extends State<AuthTile> {
  @override
  Widget build(BuildContext context) {
    final reverse = widget.reverse ?? false;
    final onTap= widget.onTap ?? (){};
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: reverse?BrandColor.black:BrandColor.grey235,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.icon??SizedBox.shrink(),
            widget.icon!=null?SizedBox(width: 10,):SizedBox.shrink(),
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 18,
                color: reverse?Colors.white: BrandColor.black,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ),
    );
  }
}