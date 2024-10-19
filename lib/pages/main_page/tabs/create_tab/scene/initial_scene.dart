import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izzi_ride_2/UI/button.dart';
import 'package:izzi_ride_2/core/bloc/create_ride_bloc/create_ride_bloc.dart';
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
                  UIButton(
                    label: "+ Create a ride",
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FromInputScene(),));
                    },
                  ),
                  SizedBox(height: 44,)
                ],
              ),
            ),
    );
  }
}