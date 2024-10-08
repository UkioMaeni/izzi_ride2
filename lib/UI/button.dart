import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class UIButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String label;
  final bool? reverse;
  final EdgeInsets? margin;
  final Function()? onTap;
  final Future<void> Function()? onFuture;
  const UIButton({
    super.key,
    required this.label,
    this.reverse,
    this.height,
    this.width,
    this.margin,
    this.onTap,
    this.onFuture
  });

  @override
  State<UIButton> createState() => _UIButtonState();
}

class _UIButtonState extends State<UIButton> {


  bool load=false;



  @override
  Widget build(BuildContext context) {
    Color bgColor=BrandColor.blue;
    Color textColor=Colors.white;
    if(widget.reverse!=null&&widget.reverse!){
      bgColor=Colors.white;
      textColor=BrandColor.blue;
    }
    final onTap=widget.onTap??(){};
    return GestureDetector(
      onTap: ()async {
        onTap();
        if(widget.onFuture!=null){
          print("start");
          if(load){
            return;
          }
          setState(() {
            load=true;
          });
          await widget.onFuture!();
          setState(() {
            load=false;
          });
          print("end");
        }
      },
      child: Container(
        margin: widget.margin,
        height: widget.height??67,
        width: widget.width??double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Builder(
          builder: (context) {
            if(load){
              return SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            return Text(
                    widget.label,
                    style: TextStyle(
                      fontFamily: BrandFontFamily.platform,
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w500
                    ),
                  );
          }
        ),
      ),
    );
  }
}