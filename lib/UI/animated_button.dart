// import 'package:flutter/material.dart';
// import 'package:izzi_ride_2/constant/constants.dart';

// class AnimatedButton extends StatefulWidget {
//   final double width;
//   final String title;
//   const AnimatedButton({super.key,required this.width,required this.title});

//   @override
//   State<AnimatedButton> createState() => _AnimatedButtonState();
// }

// class _AnimatedButtonState extends State<AnimatedButton> {


//   late double _width;
//   @override
//   void initState() {
//     _width=SPACE;
//     super.initState();
//   }

//   final double SPACE=2;
//   @override
//   Widget build(BuildContext context) {
    
//     return GestureDetector(
//       onTap: ()async {
        
//         _width=_width+SPACE;
//         setState(() {
          
//         });
//       },
//       onTapDown: (details) {
//         _width=_width-SPACE;
//         setState(() {
          
//         });
//       },
//       onTapUp: (details) {
        
//       },
//       onTapCancel: () {
//         _width=_width+SPACE;
//         setState(() {
          
//         });
//       },
//       child: Align(
//         child: Container(
//           height: 63+SPACE*2,
//           alignment: Alignment.center,
//           child: AnimatedContainer(
//             height: 63,
//             width: widget.width-40,
//             margin: EdgeInsets.only(top: 8-_width*2,left: _width*2),
//             decoration: BoxDecoration(
//               color: BrandColor.blue,
//               borderRadius: BorderRadius.circular(10),
//               boxShadow: [
//                 BoxShadow(color: BrandColor.blue.withAlpha(200),offset: Offset(-_width, _width),blurRadius: 0)
//               ]
//             ),
          
//             duration: Duration(milliseconds: 100),
//             curve: Curves.bounceIn,
//             alignment: Alignment.center,
//             child: Text(widget.title),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:izzi_ride_2/constant/constants.dart';

class AnimatedButton extends StatefulWidget {
  final double width;
  final String title;
  final Function()? onTap; 
  const AnimatedButton({super.key,required this.width,required this.title,this.onTap});
  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(10),
      
      child: Ink(
        height: 63,
        width: double.infinity,
        decoration: BoxDecoration(
          color: BrandColor.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.only(left: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title,
            style: TextStyle(
              fontFamily: "SF",
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}