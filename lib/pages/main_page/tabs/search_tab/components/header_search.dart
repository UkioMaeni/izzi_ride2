import 'package:flutter/material.dart';
import 'package:izzi_ride_2/UI/animated_button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/search_tab/scenaries_page/from_search_scene.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class HeaderSearch extends StatelessWidget {
  const HeaderSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
            Text(
              "iZZi Ride",
              style: TextStyle(
                fontFamily: "SF",
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: BrandColor.black
      
              ),
              
            ),
            SizedBox(height: 34,),
            AnimatedButton(
              width: MediaQuery.of(context).size.width,
              title: "Book now",
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => FromSearchScene(),));
              },
            )
            
            // PrettyWaveButton(
            //   duration: Duration(milliseconds: 400),
            //   backgroundColor: BrandColor.blue,
            //   borderRadius: 10,
              
            //   child:  SizedBox(
            //     width: 200,
            //     child: Text(
            //         "Book now",
            //         style: TextStyle(
            //           fontFamily: "SF",
            //           fontSize: 24,
            //           fontWeight: FontWeight.w500,
            //           color: Colors.white
                       
            //         ),
                    
            //       ),
            //   ),
              
            //   onPressed: (){}
            // ),
           
        ],
      ),
    );
  }
}