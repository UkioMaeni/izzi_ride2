import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class UIButton extends StatefulWidget {
  final double? width;
  final double? height;
  final String label;
  final bool? reverse;
  final bool? alternate;
  final EdgeInsets? margin;
  final Function()? onTap;
  final bool? enabled;
  final Color? backgroundColor;
  final Color? textColor;
  final Future<void> Function()? onFuture;
  final Widget? child;
  const UIButton({
    super.key,
    required this.label,
    this.reverse,
    this.alternate,
    this.height,
    this.width,
    this.margin,
    this.onTap,
    this.onFuture,
    this.enabled,
    this.backgroundColor,
    this.child,
    this.textColor,
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
    if(widget.alternate!=null&&widget.alternate!){
      bgColor=Colors.white;
      textColor=BrandColor.black69;
    }
    if(widget.alternate!=null&&widget.alternate!&&widget.backgroundColor==null){
      bgColor=widget.backgroundColor!;
    }
    if(widget.textColor!=null){
      textColor=widget.textColor!;
    }
    final onTap=widget.onTap??(){};
    return GestureDetector(
      onTap: ()async {
        if(widget.enabled!=null && !widget.enabled! ) return;
        onTap();
        if(widget.onFuture!=null){
          
          if(load){
            return;
          }
          setState(() {
            load=true;
          });
          print("start future");
          await widget.onFuture!();
          print("end future");
          setState(() {
            load=false;
          });
          
        }
      },
      child: Container(
        margin: widget.margin,
        height: widget.height??67,
        width: widget.width??double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: widget.alternate!=null&&widget.alternate!
            ?Border.all(color: widget.backgroundColor??BrandColor.blue):null
        ),
        child: Builder(
          builder: (context) {
            if(load||(!(widget.enabled??true))){
              return SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
            if(widget.child!=null){
              return Align(
                alignment: Alignment.center,
                child: widget.child!
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