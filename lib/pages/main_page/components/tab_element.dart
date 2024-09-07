import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class TabElement extends StatefulWidget {
  final int currentPage;
  final int page;
  final String iconPath;
  final String label; 
  final Function() onChange;
  const TabElement({super.key,required this.iconPath,required this.label,required this.onChange,required this.currentPage,required this.page});

  @override
  State<TabElement> createState() => _TabElementState();
}

class _TabElementState extends State<TabElement> with SingleTickerProviderStateMixin{

  late final AnimationController _animationController;
  late final Animation _animation;

  @override
  void initState() {
    _animationController= AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
      
    );
    _animation=ColorTween(begin: BrandColor.blue,end: BrandColor.grey).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.currentPage!=widget.page){
      _animationController.forward();
    }else{
      _animationController.reverse();
    }
    return Expanded(
      child: GestureDetector(
        onTap: widget.onChange,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              color: Colors.white,
              child: Column(
                  children: [
                    SizedBox(height: 14,),
                    SvgPicture.asset(widget.iconPath,color: _animation.value,),
                    SizedBox(height: 8,),
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontFamily: "SF",
                        fontSize: 12,
                        color: _animation.value,
                        fontWeight: FontWeight.w400
                      ),
                    )
                  ],
                ),
            );
          },
          
        ),
      )
    );
  }
}