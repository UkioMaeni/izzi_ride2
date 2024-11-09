import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8,),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(left: 36),
              height: 50,
              alignment: Alignment.centerLeft,
              child: R.SVG.NavigationBackIcon,
            ),
          ),
      ],
    );
  }
}