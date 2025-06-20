import 'package:flutter/cupertino.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/resources/resoursec.dart';

class TripCardPendingStatus extends StatelessWidget {
  const TripCardPendingStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: BrandColor.lightYellow,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Stack(
            children: [
              R.SVG.PendingStatusIcon,
              // Positioned(
              //   right: 0,
              //   top: 0,
              //   child: Container(
              //     height: 12,
              //     width: 12,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       color: BrandColor.red,
              //       borderRadius: BorderRadius.circular(12)
              //     ),
              //     child: Text(
              //       "newTravalers.length.toString()",
              //       textAlign: TextAlign.start,
              //       style: TextStyle(
              //         fontFamily: "SF",
              //         fontSize: 8,
              //         color:BrandColor.white,
              //         fontWeight: FontWeight.w400
              //       ),
              //     ),
              //   )
              // )
            ],
          ),
          SizedBox(width: 10,),
          Text(
            "Waiting for confirmation",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: "SF",
              fontSize: 20,
              color:BrandColor.yellow,
              fontWeight: FontWeight.w400
            ),
          )
        ],
      )
      
    );
  }
}