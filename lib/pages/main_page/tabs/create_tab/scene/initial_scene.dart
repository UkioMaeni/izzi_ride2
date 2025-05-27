import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/constant/constants.dart';
import 'package:izzi_ride_2/core/app_routing/app_routing.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
import 'package:izzi_ride_2/core/models/enum_ride_type.dart';
import 'package:izzi_ride_2/pages/main_page/tabs/create_tab/scene/from_input_scene.dart';

class CreateRideInitialScene extends StatefulWidget {

  const CreateRideInitialScene({
    super.key,
  });

  @override
  State<CreateRideInitialScene> createState() => _CreateRideInitialSceneState();
  

}

class _CreateRideInitialSceneState extends State<CreateRideInitialScene> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: typeRideVariable(
                      title: "I'm the driver",
                      subtitle: "I have free seats",
                      type: EnumRideType.driver
                    )
                  ),
                  Expanded(
                    child: typeRideVariable(
                      title: "I am a passenger",
                      subtitle: "Looking for a passing car",
                      type: EnumRideType.client
                    )
                  ),
                  Expanded(
                    child: typeRideVariable(
                      title: "Delivery",
                      subtitle: "I can deliver the package",
                      type: EnumRideType.delivery
                    )
                  ),
                  SizedBox(height: 55,),
                  UIButton(
                    label: "+ Create a ride",
                    onTap: () {
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => FromInputScene(),));
                      context.pushNamed(RoutesName.createFromInput);
                    },
                  ),
                  SizedBox(height: 44,)
                ],
              ),
            ),
    );
  }

  Widget typeRideVariable({required String title,required String subtitle,required EnumRideType type}){
    final currentRideType= context.watch<CreateRideBloc>().state.rideType;
    return GestureDetector(
      onTap: () {
        context.read<CreateRideBloc>().add(CreateRideEditRideType(rideType: type));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top:32 ),
        padding: EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: currentRideType==type?BrandColor.blue:BrandColor.black69
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 26,
                color: BrandColor.black69,
                fontWeight: FontWeight.w700
              ),
            ),
            SizedBox(height: 10,),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: BrandFontFamily.platform,
                fontSize: 12,
                color: BrandColor.black69,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
      ),
    );
  }


}